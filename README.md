# README

- насервере должен быть установлен ImageMagic (для загрузки картинок на сервер)


rails RAILS_ENV=production db:schema:load
rails RAILS_ENV=production db:seed

CONFIGURE_OPTS="--disable-install-rdoc" rbenv install 2.4.2
x текседитор
x создание таска с пустым парент таском
x создание таска с пустым ассигни

x нельзя создать новый таск, пока в проекте нет и одной категории
- удалить категорию можно только если нету тасков с этой категорией
- урезать права обычного юзера внутри проекта
- вернуть Tasks в шапку - назначенные на текущего юзера
- апдейты при изменении таков...


rvm use ruby-2.4.1@rails5.1.4

* Admin может все (пока не может измениять пароли юзеров)
* Project Manager
	- создавать новые проекты (назначается автором этого проекта)
	- создавать таски внутри созданного проекта
	- назначать юзеров на таски внутри созданного проекта
	- назначать юзеров на роли в проекте
	- видеть все внутри созданного проекта
* User
	- видеть все внутри проекта, если он есть в списке испольнителей
	- создавать сабтаски внутри таска, на которого он назначен

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 2.4.1

* Rails version 5.1.4

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
