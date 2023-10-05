FROM quay.io/strimzi/kafka:0.37.0-kafka-3.5.1
USER root:root
RUN mkdir -p /opt/kafka/plugins/debezium
COPY ./debezium-connector-mysql/ /opt/kafka/plugins/debezium/
USER 1001