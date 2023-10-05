# Create namespace
kubectl create namespace kafka
# Deploy Strimzi operator
kubectl create -f strimzi-kafka.yaml -n kafka
# Create Apache Kafka Cluster
# kubectl apply -f kafka-persistent-single.yaml -n kafka
# Apply Secret
kubectl apply -f secret.yaml -n kafka
# Role
kubectl apply -f role.yaml -n kafka
# Rolebinding
kubectl apply -f rolebinding.yaml -n kafka
# Create Apache Kafka Cluster
kubectl apply -f kafka.yaml -n kafka
# MYSQL
# kubectl apply -f mysql.yaml -n kafka
# Kafka Connect
kubectl apply -f connect.yaml -n kafka
# Kafka Connect API
kubectl apply -f connect-api.yaml -n kafka
# Verify the Deployment
kubectl run -n kafka -it --rm --image=quay.io/debezium/tooling:1.2  --restart=Never watcher -- kcat -b debezium-cluster-kafka-bootstrap:9092 -C -o --from-beginning -t mysql.inventory.customers
kubectl run -n kafka -it --rm --image=quay.io/debezium/tooling:1.2  --restart=Never watcher2 -- kcat -b debezium-cluster-kafka-bootstrap:9092 -C -o --from-beginning -t mysql.inventory.test
kubectl run -n kafka -it --rm --image=mysql:8.0 --restart=Never --env MYSQL_ROOT_PASSWORD=debezium mysqlterm -- mysql -hmysql -P3306 -uroot -pdebezium