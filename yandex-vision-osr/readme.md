# Yandex Vision OCR

Yandex Vision OCR - это OCR-инструмент для оцифровки текста с изображений (распознование образов). Это платный сервис [YandexCloud](https://yandex.cloud/ru/docs/vision/operations/ocr/text-detection-image).

## Как попробовать без кодирования

Кодируем файл с изображением в формат Base64:

```bash
base64 -i check001.jpeg > output.txt
```

Далее обращаемся к YandexCloud:

```bash
export IAM_TOKEN=`yc iam create-token`
curl --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --header "x-data-logging-enabled: true" \
  --header "x-folder-id: b1gdtl2rf29n03bd49nn" \
  --data "@/Users/igorsimdanov/www/thinknetica/arch-event-driven/yandex-vision-osr/body.json" \
  https://ocr.api.cloud.yandex.net/ocr/v1/recognizeText --output output.json
```

Извлечь результат из полученного json-а можно, обратившись к result->textAnnotation->fullText
