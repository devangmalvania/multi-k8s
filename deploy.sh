docker build -t dmalvania/multi-client:latest -t dmalvania/multi-client:$SHA ./client/Dockerfile ./client
docker build -t dmalvania/multi-server:latest -t dmalvania/multi-server:$SHA ./server/Dockerfile ./server
docker build -t dmalvania/multi-worker:latest -t dmalvania/multi-worker:$SHA ./worker/Dockerfile ./worker
docker push dmalvania/multi-client:latest
docker push dmalvania/multi-server:latest
docker push dmalvania/multi-worker:latest

docker push dmalvania/multi-client:$SHA
docker push dmalvania/multi-server:$SHA
docker push dmalvania/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dmalvania/multi-server:$SHA
kubectl set image deployments/client-deployment client=dmalvania/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dmalvania/multi-worker:$SHA