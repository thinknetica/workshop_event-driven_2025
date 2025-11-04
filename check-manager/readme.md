# CheckManager

Сервис предназначен для координации работ по распознаванию текста с изображения чека. Он перенаправляет микросервису распознавания сообщение и получает ответ. В качестве сервиса распознавания могут служить сервисы tesseract и yandex_vision. После получения ответа от этих сервисов распознанный текст передается далее сервису CheckRuler без дополнительной интерпретации.

## Точки входа

Приложение имеет две точки входа. Пользователи могут обращаться к системе администрирования через HTTP, для этого запускается веб-сервер puma

```sh
bundle exec rails s
```

Кроме того, приложение слушает RabbitMQ-сообщения, для этого поднимается sneakers-обработчик 

```sh
bundle exec rails sneakers:run
```

## RabbitMQ

Панель управления RabbitMQ можно найти по ссылке http://localhost:15672/

## Отправка тестового сообщения

```
bundle exec rails fake_message:start
```

## TODO

Формируем список задач по CheckManager

* Формируем модель Check
* Формируем привязку событий к модели Check

## Запуск в docker

Подготовка

```bash
docker compose build
COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker compose run -e "RAILS_ENV=development" check-manager bundle exec rake db:drop db:create db:migrate
```

Запуск:

```bash
docker compose up
```

Доступ к командной строке:

```bash
docker compose exec -it check-manager bash
```
