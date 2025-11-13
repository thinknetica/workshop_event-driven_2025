# Tesseract

Tesseract - это OCR-инструмент для оцифровки текста с изображений (распознование образов). Домашняя страница проекта на [github](https://github.com/tesseract-ocr/tesseract).

Документация по tesseract может быть обнаружена в отдельном [github-проекте](https://github.com/tesseract-ocr/tessdoc).

## Установка в macos

Под macos установить tesseract можно при помощи команды:

```bash
brew install tesseract
```

По умолчанию устанавливается только английский язык. Для установки поддержки языков, можно воспользоваться командой:

```bash
brew install tesseract-lang
```

Посмотреть поддерживаемые языки можно при помощи команды:

```bash
tesseract --list-langs
```

## Установка в ubuntu

В ubuntu установить tesseract и инструменты разработки можно при помощи следующих команд:

```bash
sudo apt install tesseract-ocr
sudo apt install libtesseract-dev
```

Поддержка русского языка

```bash
sudo apt install tesseract-ocr-rus
```

Поддержка всех языков

```bash
sudo apt install tesseract-ocr-all
```

## Использование в docker-экосистеме


Запуск tesseract в docker

```bash
docker compose up
```

Получение ответа по REST

```bash
curl -X POST \
  -H 'content-type: application/x-www-form-urlencoded' \
  --data-binary "@/Users/igorsimdanov/www/thinknetica/arch-event-driven/tesseract/eurotext.png" \
  'http://localhost:3000/image-to-text'
```

Проверка чеков

```bash
curl -X POST \
  -H 'content-type: application/x-www-form-urlencoded' \
  --data-binary "@/Users/igorsimdanov/www/thinknetica/arch-event-driven/tesseract/check001.jpeg" \
  'http://localhost:3000/image-to-text'
```

## Как пользоваться?

Узнать версию tesseract можно при помощи команды:

```bash
tesseract --version
```

Расшифровка картинки, текст сохраняется в файл output.txt

```bash
tesseract eurotext.png output --oem 1 -l eng
```

Расшифровка без вывода в файл

```bash
tesseract eurotext.png stdout --oem 1 -l eng
tesseract check001.jpg stdout --oem 1 -l rus
tesseract check002.jpg stdout --oem 1 -l rus
```
