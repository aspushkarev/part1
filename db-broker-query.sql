-- Запрос показывающий состояние счёта инвестора

SELECT bou.user_id, SUM(bou.cash) AS cash, bou.currency_id FROM bill_of_users bou
WHERE bou.user_id = 1
GROUP BY currency_id 
ORDER BY currency_id;

SELECT c.abbreviation, c.symbol FROM currencys c
WHERE c.id = 1;

-- Итоговый запрос с подзапросами показывающий состояние счёта инвестора

SELECT
	bou.user_id,
	SUM(bou.cash) AS cash,
	(SELECT c.symbol FROM currencys c WHERE c.id = bou.currency_id) AS symbol,
	(SELECT c2.abbreviation FROM currencys c2 WHERE c2.id = bou.currency_id) AS abbreviation
FROM bill_of_users bou WHERE bou.user_id = 1
GROUP BY currency_id 
ORDER BY currency_id;


/*
* Представления
*/

-- представление, показывающее портфели инвесторов (то есть список всех инвесторов с эмитентами, сделки по которым не закрыты)

CREATE OR REPLACE VIEW view_bags AS
SELECT u.id, u.firstname, u.lastname, u.patronymic, i.ticker_symbol, i.name_of_the_issuer, d.quantity FROM user_profiles up 
JOIN users u ON up.user_id = u.id
JOIN deals d ON d.user_id = u.id
JOIN issuer i ON i.id = d.issuer_id 
WHERE d.closed = 'no'
ORDER BY u.id;

-- Показать все портфели инвесторов

SELECT * FROM view_bags;

-- Показать портфель инвестора 5

SELECT * FROM view_bags 
WHERE id = 5;

-- Представление для отображения подробной информации по эмитенту из портфеля инвестора

SELECT * FROM issuer i;

CREATE OR REPLACE VIEW view_issuer_from_bags AS
SELECT 	u.id,
		u.firstname, 
		u.lastname, 
		u.patronymic,
		i.name_of_the_issuer,						 -- name_of_the_issuer - название эмитента
		d.quantity, 								 -- quantity - количество ценных бумаг
		i.price,									 -- price - текущая цена на рынке
		d.price AS book_price,						 -- book_price - балансовая цена
		(SELECT d.quantity * i.price) AS value, 	 -- value - стоимость
		(SELECT d.quantity * d.price) AS book_value, -- book_value - балансовая стоимость
		(SELECT book_value - value) AS revaluation	 -- revaluation - переоценка (за всё время)
FROM  issuer i  
JOIN deals d ON i.id = d.issuer_id
JOIN users u ON u.id = d.user_id
WHERE d.closed = 'no' AND u.id = 4
ORDER BY u.id;

SELECT * FROM view_issuer_from_bags;

-- Представление, показывающее историю сделок с ценными бумагами по выбранному инвестору (например инвестор номер 4)

CREATE OR REPLACE VIEW view_history_deals AS
SELECT CONCAT(u.firstname, ' ', u.lastname, ' ', u.patronymic) AS name, i.name_of_the_issuer, d.deal, d.quantity, d.price, (SELECT d.quantity * d.price) AS book_value FROM deals d
INNER JOIN issuer i ON d.issuer_id = i.id
INNER JOIN users u ON u.id = d.user_id 
WHERE u.id = 4;

SELECT * FROM view_history_deals;

/*
 * Функции
 */

-- Фнукция сравнивает текущее время с временем работы биржи

DROP FUNCTION IF EXISTS check_time;

DELIMITER //

CREATE FUNCTION check_time()
RETURNS VARCHAR(20) DETERMINISTIC
BEGIN
	
	DECLARE hours TIME;
	
	SET hours = CURTIME();
	
	IF hours > '23:00:00' AND hours < '7:00:00'
	THEN
		RETURN 'Торги закрыты';	
	ELSE 
		RETURN 'Торги открыты';
	END IF;
	
END//

DELIMITER ;

SELECT check_time();

/*
 * Процедуры
 */

-- Добавляем нового инвестора через процедуру и транзакцию

DROP PROCEDURE IF EXISTS add_new_investor;

DELIMITER //

CREATE PROCEDURE add_new_investor (firstname VARCHAR(50), lastname VARCHAR(50), patronymic VARCHAR(50),
birthday DATE, gender enum('мужской', 'женский'), citizenship VARCHAR(30), login VARCHAR(30), 
password_hash CHAR(55), phone CHAR(11), email VARCHAR(120), number_of_contract CHAR(10), date_of_contract DATETIME, 
brokerage_account CHAR(15), individual_investment_account CHAR(15), invest_profile_id INT, qualifying_investor_status ENUM('FALSE','TRUE'), OUT tran_result VARCHAR(200))
BEGIN
	DECLARE tran_rollback BOOL DEFAULT 0;
	DECLARE code VARCHAR(100);
	DECLARE error_string VARCHAR(100); 
	
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		SET tran_rollback := 1;
		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
		SET tran_result := CONCAT(code, ': ', error_string);
	END;

	START TRANSACTION;
	
	INSERT INTO users (firstname, lastname, patronymic, birthday, gender, citizenship)
	VALUES (firstname, lastname, patronymic, birthday, gender, citizenship);

	INSERT INTO user_profiles (user_id, login, password_hash, phone, email, number_of_contract, date_of_contract, brokerage_account, individual_investment_account, invest_profile_id, qualifying_investor_status)
	VALUES (last_insert_id(), login, password_hash, phone, email, number_of_contract, date_of_contract, brokerage_account, individual_investment_account, invest_profile_id, qualifying_investor_status);
	
	IF tran_rollback THEN
		ROLLBACK;
	ELSE
		SET tran_result := 'Successfully!';
		COMMIT;
	END IF;
END//

DELIMITER ;

-- вызываем процедуру для добавления инвестора

CALL add_new_investor('Пётр', 'Петрович', 'Петров', '1959-03-21', 'мужской', 'Россия', 
				  'kfej', 'kjkjtrh954mgkfjn7fng1', '89029772796', 'petr02@mail.ru', '123532/20', '2020-12-04', '451683', '384692', 3, TRUE, @tran_result);
				 
SELECT @tran_result;

SELECT * FROM users;

SELECT * FROM user_profiles up;


-- Покупка/продажа ценных бумаг через процедуру и транзакцию

DROP PROCEDURE IF EXISTS deal_stocks;

DELIMITER //

CREATE PROCEDURE deal_stocks (IN user_id BIGINT, type_of_bid_id INT, issuer_id BIGINT, deal ENUM('buy','sell'), quantity INT, price DECIMAL(11,2), currency_id INT, OUT tran_result VARCHAR(200))
BEGIN
	DECLARE tran_rollback BOOL DEFAULT 0;
	DECLARE code VARCHAR(100);
	DECLARE error_string VARCHAR(100);
	DECLARE old_cash DECIMAL(11,2);

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN 
		SET old_cash = (SELECT cash FROM bill_of_users bou WHERE bou.id = user_id);
		SET tran_rollback = 1;
		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
		SET tran_result = CONCAT(code, ':', error_string);
	END;

	START TRANSACTION;

	INSERT INTO deals (user_id, type_of_bid_id, issuer_id, deal, quantity, price, currency_id)
	VALUES (user_id, type_of_bid_id, issuer_id, deal, quantity, price, currency_id);

	UPDATE bill_of_users
	SET cash := old_cash - (quantity * price)
	WHERE id = user_id;
	
	IF tran_rollback THEN
		ROLLBACK;
	ELSE
		SET tran_result = 'Successfully!';
		COMMIT;
	END IF;
	
END //

DELIMITER ;

CALL deal_stocks (17, 2, 8, 'buy', 3, 94, 1, @tran_result); -- У инвестора номер 17 недостаточно кэша для покупки ценной бумаги

CALL deal_stocks (1, 2, 8, 'buy', 3, 94, 1, @tran_result); -- У инвестора под номером 1 достаточно средств для сделки. Сделка прошла успешно, изменения закомичены

SELECT @tran_result;

SELECT * FROM deals;

SELECT * FROM bill_of_users;

/*
* Триггеры
*/

-- Триггер проверяет дату рождения при добавлении инвестора. Инвестор должен быть совершеннолетний

DROP TRIGGER IF EXISTS check_birthday_before_insert;

DELIMITER //

CREATE TRIGGER check_birthday_before_insert BEFORE INSERT ON users
FOR EACH ROW
BEGIN
	IF TIMESTAMPDIFF(YEAR, NEW.birthday, CURRENT_DATE()) < 18 THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert Canceled. You are do not adult!';
	END IF;
END//

DELIMITER ;

-- При попытке вставить инвестора младше 18 лет, код выдаст ошибку '45000'

INSERT INTO users 
VALUES (DEFAULT, 'Михаил', 'Сергеевич', 'Горбачёв', '2012-11-03', 'мужской', 'Россия', DEFAULT, DEFAULT);

-- Триггер проверяет счёт при выполнении покупки или продажи ценной бумаги (после операции счёт не может быть пуст)

DROP TRIGGER IF EXISTS check_cash_after_update;

DELIMITER //

CREATE TRIGGER check_cash_after_update AFTER UPDATE ON bill_of_users
FOR EACH ROW
BEGIN 
	IF NEW.cash <= '0' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough cash. You must top up your account!';
	END IF;
END //

DELIMITER ;

-- Проверяем работу триггера. При обновлении счёта последний не должен быть меньше нуля

UPDATE bill_of_users
SET cash = 0
WHERE id = 1;

-- В следующей версии можно:

-- Сделать таблицу Условия обслуживания (тарифы, необеспеченные сделки);
-- Написать запрос, показывающий долю эмитента в портфеле инвестора;
-- Исправить названия таблиц (вместо users использовать investors, user_profiles -> investor_profiles, bill_of_users -> bill_of_investor)...


