# Create namespace
kubectl delete namespace kafka
# Deploy Strimzi operator
kubectl delete -f strimzi-kafka.yaml -n kafka
# Create Apache Kafka Cluster
kubectl delete -f kafka-persistent-single.yaml -n kafka
# Apply Secret
kubectl delete -f secret.yaml -n kafka
# Role
kubectl delete -f role.yaml -n kafka
# Rolebinding
kubectl delete -f rolebinding.yaml -n kafka
# Create Apache Kafka Cluster
kubectl delete -f kafka.yaml -n kafka
# MYSQL
kubectl delete -f mysql.yaml -n kafka
# Kafka Connect
kubectl delete -f connect.yaml -n kafka
# Kafka Connect API
kubectl delete -f connect-api.yaml -n kafka
# Verify the Deployment
kubectl run -n kafka -it --rm --image=quay.io/debezium/tooling:1.2  --restart=Never watcher -- kcat -b debezium-cluster-kafka-bootstrap:9092 -C -o beginning -t mysql.inventory.customers

kubectl run -n kafka -it --rm --image=mysql:8.0 --restart=Never --env MYSQL_ROOT_PASSWORD=debezium mysqlterm -- mysql -hmysql -P3306 -uroot -pdebezium