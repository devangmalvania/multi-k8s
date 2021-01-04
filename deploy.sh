docker build -t dmalvania/multi-client:latest -t dmalvania/multi-client:$SHA ./client/dockerfile ./client
docker build -t dmalvania/multi-server -t dmalvania/multi-server:$SHA ./server/dockerfile ./server
docker build -t dmalvania/multi-worker -t dmalvania/multi-worker:$SHA ./worker/dockerfile ./worker
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