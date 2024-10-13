# Что сделано
1. Поднят инстанс PostgreSQL в docker.
2. Написан DDL для заданной структуры данных в SQL файл createbd.sql.
3. Выполнена репликация.
4. Написан скрипт для подсчета пассажиропотока в виде view (createview.sql).

# Как запустить
1. sh docker-init.sh
2. Подключиться к db, например, с помощью dbeaver
   - user='postgres'
   - password='postgres'
   - host='localhost'
   - port='5432'
