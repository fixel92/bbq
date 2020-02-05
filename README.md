# Сайт для организации мероприятий "Шашлыки"

#### Установка
```
git clone git@github.com:fixel92/bbq.git
cd bbq/
bundle install
```

#### Настройка
В файл `confif/application.yml` вносим переменные:
```
EMAIL: "***************"
EMAIL_PASS: "***********"
OMNIAUTH_FACEBOOK_ID: "*************"
OMNIAUTH_FACEBOOK_SECRET: "**************************"
OMNIAUTH_VKONTAKTE_ID: "********"
OMNIAUTH_VKONTAKTE_SECRET: "*************************"
```
Настройте postfix на вашем сервере для отправки писем.

Устновите Redis

#### Зависимости

* Ruby версии не ниже 2.6.0

