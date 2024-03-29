# Физическая модель
---

Таблица Venue:

| Название    | Описание                | Тип данных    | Ограничение |
|-------------|-------------------------|---------------|-------------|
| venue_id    | Идентификатор           | serial        | primary key |
| name        | Короткое название       | varchar(50)   | not null    |
| location    | Координаты              | point         | not null    |
| description | Описание                | varchar(1000) |             |
| owner_id    | Идентификатор владельца | integer       | not null    |

Таблица User (версионная):

| Название            | Описание                       | Тип данных  | Ограничение |
|---------------------|--------------------------------|-------------|-------------|
| user_id             | Идентификатор                  | serial      | primary key |
| email               | Почтовый адрес пользователя    | varchar(50) | not null    |
| phone               | Номер телефона пользователя    | varchar(15) | not null    |
| registration_date   | Время регистрации пользователя | timestamp   | not null    |
| deregistration_date | Время удаления аккаунта        | timestamp   |             |  

Таблица Owner (версионная):

| Название            | Описание                    | Тип данных  | Ограничение |
|---------------------|-----------------------------|-------------|-------------|
| owner_id            | Идентификатор               | serial      | primary key |
| email               | Почтовый адрес владельца    | varchar(50) | not null    |
| phone               | Номер телефона владельца    | varchar(15) | not null    |
| registration_date   | Время регистрации владельца | timestamp   | not null    |
| deregistration_date | Время удаления аккаунта     | timestamp   |             |

Таблица UserReview:

| Название | Описание                                   | Тип данных   | Ограничение           |
|----------|--------------------------------------------|--------------|-----------------------|
| user_id  | Идентификатор пользователя (обьект отзыва) | integer      | not null, foreign key |
| owner_id | Идентификатор владельца (автор отзыва)     | integer      | not null, foreign key |
| rating   | Оценка                                     | smallint     | 1-5                   |
| comment  | Текстовый отзыв                            | varchar(500) |                       |

Таблица Amenity (внутренняя):

| Название    | Описание          | Тип данных   | Ограничение |
|------------ |-------------------|------------ -|-------------|
| amenity_id  | Идентификатор     | serial       | primary key |
| name        | Короткое название | varchar(50)  | not null    |
| description | Описание          | varchar(300) | not null    |

Таблица Venue_x_Amenity:

| Название   | Описание               | Тип данных | Ограничение           |
|------------|------------------------|------------|-----------------------|
| venue_id   | Идентификатор обьекта  | integer    | not null, foreign key |
| amenity_id | Идентификатор удобства | integer    | not null, foreign key |

Таблица VenueReview:

| Название | Описание                                  | Тип данных   | Ограничение           |
|----------|-------------------------------------------|--------------|-----------------------|
| venue_id | Идентификатор объекта (объект отзыва)     | integer      | not null, foreign key |
| user_id  | Идентификатор пользователя (автор отзыва) | integer      | not null, foreign key |
| rating   | Оценка                                    | smallint     | 1-5                   |
| comment  | Текстовый отзыв                           | varchar(500) |                       |

Таблица Rate (внутренняя):

| Название    | Описание          | Тип данных   | Ограничение |
|------------ |-------------------|--------------|-------------|
| rate_id     | Идентификатор     | serial       | primary key |
| name        | Короткое название | varchar(50)  | not null    |
| description | Описание          | varchar(300) | not null    |

Таблица Offer:

| Название      | Описание                  | Тип данных | Ограничение           |
|---------------|---------------------------|------------|-----------------------|
| offer_id      | Идентификатор             | serial     | primary key           |
| venue_id      | Идентификатор объекта     | integer    | not null, foreign key |
| rate_id       | Идентификатор тарифа      | integer    | not null, foreign key |
| price         | Величина одного платежа $ | money      |                       |


Таблица OfferHistory:

| Название      | Описание                  | Тип данных | Ограничение           |
|---------------|---------------------------|------------|-----------------------|
| offer_id      | Идентификатор предложения | integer    | not null, foreign key |
| valid_to      | Дата потери актуальности  | timestamp  | not null              |
| price         | Величина одного платежа $ | money      |                       |

Таблица Booking:

| Название    | Описание                   | Тип данных | Ограничение           |
|-------------|----------------------------|------------|-----------------------|
| user_id     | Идентификатор пользователя | integer    | not null, foreign key |
| offer_id    | Идентификатор предложения  | integer    | not null, foreign key |
| start_date  | Время начала               | timestamp  | not null              |
| finish_date | Время завершения           | timestamp  |                       |

