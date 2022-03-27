# TakeAndSendPhotos
You can log in through the server, take several photos (information about them is recorded in the Realm) and send them to the server (using URLSession)

### Задание:

Написать приложение, которое авторизовавшись через сервер, просит пользователя сделать N-ое количество фотографий. Информацию о каждой фотографии сохранять в БД. Далее, все сделанные фотографии асинхронно (в идеале - в бэкграунде) отправляются на сервер. В случае, если сервер вернул ошибку токена - незаметно для пользователя приложение получат новый токен на основании введённых ранее авторизационных данных и продолжает отправку фото с новым токеном. После отправки фото приложение должно отправить дамп БД (файл *.realm). 
Таблица в бд с файлами должна быть примерной структуры: id, name, created, send

### Авторизация

https://test.dewival.com/api/login/
логин - пароль: test - 123456
Метод POST, Content-type - application/json
При отправке пароль должен быть закодирован в base64
В ответ придет токен (JWT) (строка)

### Отправка файла
https://test.dewival.com/api/sendfile/
Авторизация ранее полученным токеном (Bearer)
Content-type - multipart/form-data

### Реализация:
- MVP
- URLSession
- Realm DB
- Programmatically (no Storyboard)
- Locksmith (Keychain)

Шаг-1: экран авторизации

<img width="256" alt="example" src="https://raw.githubusercontent.com/semjonG/TakeAndSendPhotos/main/1screen.png"><br>

Шаг-2: экран перехода к выбору фото

<img width="256" alt="example" src="https://raw.githubusercontent.com/semjonG/TakeAndSendPhotos/main/2screen.png"><br>

Шаг-3: экран выбора и отправки фото (по нажатию на кнопку Done выбранные изображения отправляются на сервер, сохраняясь в Realm перед отправкой)

<img width="256" alt="example" src="https://raw.githubusercontent.com/semjonG/TakeAndSendPhotos/main/3screen.png"><br>
