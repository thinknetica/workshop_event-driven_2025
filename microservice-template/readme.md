# Микросервисное шасси

Репозиторий содержит шаблон для генерации каркаса Rails приложения
Для того чтобы создать новое приложения используя шаблон нужно выполнить команду:

```sh
rails new awesome-template -m microservice-template/template.rb
```

Для конфигурирования приложения предусмотрены следующие флаги:

- `--skip-rabbitmq` - без взаимодействия с RabbitMQ
- `--skip-active-admin` -  без панели администрирования
- `--skip-db` - без базы данных

Микросервис для принятия решения (CheckManager):

```sh
rails _8.0.3_ new check-manager --database=postgresql --skip-action-mailbox --skip-action-text --skip-action-cable --skip-hotwire --skip-jbuilder --skip-test --skip-system-test --skip-bootsnap --skip-ci --skip-kamal --skip-solid --skip-javascript -m microservice-template/template.rb
```

Микросервис для распознавания изображения (Tesseract):

```sh
rails _8.0.3_ new tesseract --api --skip-action-mailbox --skip-action-text --skip-action-cable --skip-hotwire --skip-jbuilder --skip-test --skip-system-test --skip-bootsnap --skip-ci --skip-kamal --skip-solid --skip-javascript -m microservice-template/template.rb
```

Микросервис для распознавания изображения (Yandex Vision OSR):

```sh
rails _8.0.3_ new yandex-vision --api --skip-action-mailbox --skip-action-text --skip-action-cable --skip-hotwire --skip-jbuilder --skip-test --skip-system-test --skip-bootsnap --skip-ci --skip-kamal --skip-solid --skip-javascript -m microservice-template/template.rb
```

Микросервис для правил (CheckRuler):

```sh
rails _8.0.3_ new check-ruler --database=postgresql --skip-action-mailbox --skip-action-text --skip-action-cable --skip-hotwire --skip-jbuilder --skip-test --skip-system-test --skip-bootsnap --skip-ci --skip-kamal --skip-solid --skip-javascript -m microservice-template/template.rb
```

Микросервис для правил (BudgetControl):

```sh
rails _8.0.3_ new budget-control --database=postgresql --skip-action-mailbox --skip-action-text --skip-action-cable --skip-hotwire --skip-jbuilder --skip-test --skip-system-test --skip-bootsnap --skip-ci --skip-kamal --skip-solid --skip-javascript -m microservice-template/template.rb
```

Микросервис для правил (CheckRegister):

```sh
rails _8.0.3_ new check-register --database=postgresql --skip-action-mailbox --skip-action-text --skip-action-cable --skip-hotwire --skip-jbuilder --skip-test --skip-system-test --skip-bootsnap --skip-ci --skip-kamal --skip-solid --skip-javascript -m microservice-template/template.rb
```

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
