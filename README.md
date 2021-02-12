# Change Data Capture example (Debezium + StreamSets)

Оригинал: https://github.com/Gorini4/debezium_cdc





## Запуск

1. Выполните в консоли `docker-compose up`. В результате будут развернуты докер-контейнеры со всеми необходимыми сервисами.
2. Для запуска коннектора Debezium выполните в консоли `make register-postgres`.
3. Чтобы увидеть логи изменений в базе, выполните `make create-consumer`. Это запустит kafka consumer, который подключится к топику, содержащему логи.

## Загрузка логов CDC в Hadoop

1. Зайдите в StreamSets по адресу [localhost:18630]. Логин/пароль: admin/admin.
2. Пропустите первый преветственный экран и создайте новый пайплайн, нажав Create New Pipeline.
3. Перед вами откроется окно редактирования пайплайна. Создайте пайплайн для загрузки логов CDC в Hadoop. Для этого вам понадобятся:
    * Kafka Consumer
    * Hadoop FS
    * Остальные операторы выбирайте на свое усмотрение

Дополнительная информация:
* [StreamSets tutorial](https://streamsets.com/documentation/datacollector/latest/help/datacollector/UserGuide/Tutorial/BasicTutorial.html)
* [Пример StreamSets + Kafka](https://youtu.be/SiZrkyEzpJc?t=491)
* Адрес Kafka - `kafka:9092`
* Адрес zookeeper - `zookeeper:2181`
* Адрес Hadoop - `hadoop:9000`
* Адрес Hadoop - `hdfs://namenode:9000`

## Требования

* Пайплайн должен загружать данные об изменениях таблицы **inventory.customers** в Hadoop
* Пайплайн должен сохранять всю историю изменений, включая операции INSERT, UPDATE, DELETE, а также проставлять тип операции в поле *act* - 'I'/'U'/'D'
* Для операций DELETE должен проставляться флаг is_deleted = true

## Критерий оценки

* Пайплайн записывает все записи в Hadoop в формате Avro в плоской структуре, которая содержит все поля исходной таблицы плюс специальные поля, описанные в требованиях (в качестве подтверждения - скриншот работающего пайплайна) - 3 балла
* Пайплайн обрабатывает все типы операций (в качестве подтверждения - описание алгоритма обработки каждой из операций с указанием использованных операторов StreamSets) - 1 балл
* Для операций DELETE проставляется флаг is_deleted (в качестве подтверждения - скриншот вкладки настроек соответствующего оператора StreamSets) - 1 балл

## Дополнительная задача

Реализовать загрузку снепшота таблицы **inventory.customers** с помощью Spark в Hadoop и прислать ссылку на репозиторий с кодом.


Avro Serialization / Deploying with Debezium containers
https://debezium.io/documentation/reference/1.4/configuration/avro.html#deploying-with-debezium-containers

StreamSets Available Stage Libraries: https://streamsets.com/documentation/datacollector/latest/help/datacollector/UserGuide/Installation/AddtionalStageLibs.html#concept_evs_xkm_s5


список доступных библиотек
docker run --rm streamsets/datacollector:3.21.0 stagelibs -list

Формат Avro с использованием конвертера Apicurio Avro
curl -X GET http://localhost:8080/api/artifacts/dbserver1.inventory.customers-key
curl -X GET http://localhost:8080/api/artifacts/dbserver1.inventory.customers-value
curl -X GET http://localhost:8080/api/artifacts/dbserver1.inventory.customers-value | jq .

curl -X GET http://localhost:8080/api/ccompat/dbserver1.inventory.customers-value
