Приступил было ~ 00:00

Закончил 2:10

Приступил 15:35

Закончил 18:12

Приступил 1:15

Закончил 3:51

Приступил 14:50

Закончил 16:50

**!** - для действия необходима авторизация, иначе будет приходить json cо словами о том, что у вас нет прав для выполнения этой операции: `{ "answer": "you do not have the right to do this"}`

Удобное расширение для хрома для запросов [ссылка](https://chrome.google.com/webstore/detail/restlet-client-rest-api-t/aejoelaoggembcahagimdiliamlcdmfm)

# User

**Создать пользователя:** POST http://localhost:3000/users/?username=tihon&password=1234

**Обновить пользователся!:** PUT http://localhost:3000/users/1?username=tihon&password=12345

**Удалить пользователся!:** DELETE http://localhost:3000/users/1


# Session

**Авторизироваться:** POST http://localhost:3000/session/?username=tihon&password=1234

**Разлогиниться:** DELETE http://localhost:3000/session


# News

**Посмотреть все новости:** GET http://localhost:3000/news

**Посмотреть конкретную новость:** GET http://localhost:3000/news/1

**Создать новость!:** 

http://localhost:3000/news?sources[]=nyt&sources[]=yandex&title=test2&content=test2&datetime=01.07.2001T13:59

1) массив `sources[]=nyt&sources[]=yandex` - массив источников
2) `title=test2` - название новости
3) `content=test2` - содержание новости
4) `datetime=01.07.2001T13:59` - время ее публикации(а не создания в БД)

**Обновить новость!:** PUT http://localhost:3000/news/1?title=new_title

**Удалить новость!:** DELETE http://localhost:3000/news/1



