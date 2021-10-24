# Backend часть проекта команды *Red Suns*

## Подготовка графовой базы данных neo4j

Установить [neo4j](https://neo4j.com/download/) desktop или создать инстанс в облаке 

## Импортирование данных

В программе импортировать файл `pt/db/accetnure-neo4j.dump`

## Подготовка MySql

Установить MySql
Создать базу данных с названием accenture
Импортировать базу данных из `pt/db/accenture.sql`

Через консоль:

`$ mysql -u username -p database_name < accenture.sql`

Или через любую СУБД

Так же доступна опция генерации базы данных под
neo4j через скрипт `import_data.py`

## Подготовка node.js

Установить [node.js](https://nodejs.org/en/)

## Установка зависимостей

Зависимости требуются в случае генерации графовой базы данных из эксель файла

```bash
    pip install pandas, openpyx, neo4j
```

## Настройка api

Параметры api указываются в файле `conf.env`

## Запуск api

```bash
    node index.js
```

## Проблемы с webview гарфов 

