# Tesseract

Tesseract - это OCR-инструмент для оцифровки текста с изображений (распознование образов). Домашняя страница проекта на [github](https://github.com/tesseract-ocr/tesseract).

Документация по tesseract может быть обнаружена в отдельном [github-проекте](https://github.com/tesseract-ocr/tessdoc).

## Установка в macos

Под macos установить tesseract можно при помощи команды:

```
brew install tesseract
```

По умолчанию устанавливается только английский язык. Для установки поддержки языков, можно воспользоваться командой:

```
brew install tesseract-lang
```

Посмотреть поддерживаемые языки можно при помощи команды:

```
tesseract --list-langs
```

## Установка в ubuntu

В ubuntu установить tesseract и инструменты разработки можно при помощи следующих команд:

```
sudo apt install tesseract-ocr
sudo apt install libtesseract-dev
```

Поддержка русского языка

```
sudo apt install tesseract-ocr-rus
```

Поддержка всех языков

```
sudo apt install tesseract-ocr-all
```

## Использование в docker-экосистеме


Запуск tesseract в docker

```
docker compose up
```

Получение ответа по REST

```
curl -X POST \
  -H 'content-type: application/x-www-form-urlencoded' \
  --data-binary "@/Users/igorsimdanov/www/thinknetica/arch-event-driven/tesseract/eurotext.png" \
  'http://localhost:3000/image-to-text'
```

Проверка чеков

```
curl -X POST \
  -H 'content-type: application/x-www-form-urlencoded' \
  --data-binary "@/Users/igorsimdanov/www/thinknetica/arch-event-driven/tesseract/check001.jpeg" \
  'http://localhost:3000/image-to-text'
```

## Как пользоваться?

Узнать версию tesseract можно при помощи команды:

```
tesseract --version
```

Расшифровка картинки, текст сохраняется в файл output.txt

```
tesseract eurotext.png output --oem 1 -l eng
```

Расшифровка без вывода в файл

```
tesseract eurotext.png stdout --oem 1 -l eng
tesseract check001.jpg stdout --oem 1 -l rus
tesseract check002.jpg stdout --oem 1 -l rus
```