def int_func(word):
    return word[0].upper() + word[1:].lower()


sentence = input('Введите предложение: ').split()
for i, word in enumerate(sentence):
    if not word.isascii() or not word.isalpha() or not word.islower():
        print('Ошибка ввода символов.')
    else:
        sentence[i] = int_func(word)
print(' '.join(sentence))
