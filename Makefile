register-postgres:
	curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-postgres.json

groups-list:
	docker-compose -f docker-compose.yml exec kafka /kafka/bin/kafka-consumer-groups.sh --bootstrap-server kafka:9092 --list

groups-status:
	docker-compose -f docker-compose.yml exec kafka /kafka/bin/kafka-consumer-groups.sh \
		--bootstrap-server kafka:9092 --all-groups --describe

topics-list:
	docker-compose -f docker-compose.yml exec kafka /kafka/bin/kafka-topics.sh --list \
		--zookeeper zookeeper:2181

customers-all:
	docker-compose -f docker-compose.yml exec kafka /kafka/bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
    --from-beginning \
    --topic dbserver1.inventory.customers

customers-last:
	docker-compose -f docker-compose.yml exec kafka /kafka/bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
		--partition 0 \
		--offset latest 1 \
    --topic dbserver1.inventory.customers

customers-key-all:
	docker-compose -f docker-compose.yml exec kafka /kafka/bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
    --from-beginning \
    --property print.key=true \
		--property print.value=false \
    --topic dbserver1.inventory.customers

customers-key-last:
	docker-compose -f docker-compose.yml exec kafka /kafka/bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
		--partition 0 \
		--offset latest 1 \
    --property print.key=true \
		--property print.value=false \
    --topic dbserver1.inventory.customers

customers-key-all-avro:
	docker-compose -f docker-compose.yml exec kafka /kafka/bin/kafka-avro-console-consumer.sh \
    --bootstrap-server kafka:9092 \
    --from-beginning \
    --property print.key=true \
		--property print.value=false \
    --topic dbserver1.inventory.customers

customers-key-last-avro:
	docker-compose -f docker-compose.yml exec kafka /kafka/bin/kafka-avro-console-consumer.sh \
    --bootstrap-server kafka:9092 \
		--partition 0 \
		--offset latest 1 \
    --property print.key=true \
		--property print.value=false \
    --topic dbserver1.inventory.customers

errors-all:
	docker-compose -f docker-compose.yml exec kafka /kafka/bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
    --from-beginning \
    --topic errors

errors-last:
	docker-compose -f docker-compose.yml exec kafka /kafka/bin/kafka-console-consumer.sh \
		--bootstrap-server kafka:9092 \
		--partition 0 \
		--offset latest 1 \
		--topic errors
