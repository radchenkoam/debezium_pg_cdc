<div align="center"><h2>PostgreSQL Change Data Capture example</h2></div>

<div align="center"><h3></br>PostgreSQL + Debezium + APICURIO Registry + Kafka + StreamSets + Hadoop</h3></div>

<div align="right">Оригинал взят <a href=https://github.com/Gorini4/debezium_cdc>отсюда</a></div>

---

### Краткое описание

- разворачивается `PostgreSQL`, в нем создается тестовая БД `inventory`  
- для фиксации всех изменений в БД создается коннектор `Debezium`  
- коннектор `Debezium` отправляет сообщения об изменениях в топик `Kafka`  
- для преобразования сообщений в формат `avro` используется хранилище схем `APICURIO Registry`  
- для создания пайплайнов загрузки собщений из `Kafka` запускается `StreamSets`  
- для хранения логов изменений в базе данных запускается `Hadoop`  

---

### Запуск

- после клонирования репозитория выполнить по очереди команды:
``` bash
$ cd debezium_pg_cdc
$ mkdir -pv ./streamsets/sdc-data
$ sudo chmod -R 777 ./streamsets/sdc-data
$ docker-compose -f docker-compose-apicurio.yml pull
$ docker-compose -f docker-compose-apicurio.yml build
$ docker-compose -f docker-compose-apicurio.yml up
$ make register-postgres-apicurio
```

---

### Дополнительная информация

:link: [Debezium Documentation / Tutorial](https://debezium.io/documentation/reference/tutorial.html)  
:link: [Debezium Documentation / Avro Serialization](https://debezium.io/documentation/reference/1.4/configuration/avro.html)  
:link: [Debezium connector for PostgreSQL](https://debezium.io/documentation/reference/1.4/connectors/postgresql.html)  
:link: [Debezium docker images Github](https://github.com/debezium/docker-images)  
:link: [StreamSets Data Collector User Guide](https://streamsets.com/documentation/datacollector/latest/help/index.html)  
:link: [StreamSets Data Collector User Guide / Basic Tutorial](https://streamsets.com/documentation/datacollector/latest/help/datacollector/UserGuide/Tutorial/BasicTutorial.html)  
:link: [StreamSets docker image Github](https://github.com/streamsets/datacollector-docker)  
:link: [Kafka 2.6 Documentation](https://kafka.apache.org/26/documentation.html)

#### Порты

Kafka: `kafka:9092`  
Zookeeper: `zookeeper:2181`  
Hadoop: `hadoop:9000`, `hdfs://namenode:9000`  

---

### Веб-интерфейсы

:link: StreamSets: <http://localhost:18630/>  
:link: Hadoop: <http://localhost:9870/>  
:link: APICURIO Registry: <http://localhost:8080/>  
:link: APICURIO Registry API: <http://localhost:8080/api>  

---

### Примечание

Посмотреть список доступных библиотек `StreamSets`:
```bash
$ docker run --rm streamsets/datacollector:3.21.0 stagelibs -list
```

Для мониторинга работы `Kafka` можно использовать команды в `Makefile`:
```bash
$ make команда
```
❗но команды с `-avro-` работать не будут (они работают только в версии с `Confluent Schema Registry`),  
❗и просмотр содержимого топиков тоже не особо полезен, т.к. содержимое будет выводиться в формате `avro`
