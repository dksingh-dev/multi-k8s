docker build -t dksingh77/multi-client:latest -t dksingh77/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dksingh77/multi-server:latest -t dksingh77/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dksingh77/multi-worker:latest -t dksingh77/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dksingh77/multi-client:latest
docker push dksingh77/multi-server:latest
docker push dksingh77/multi-worker:latest

docker push dksingh77/multi-client:$SHA
docker push dksingh77/multi-server:$SHA
docker push dksingh77/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dksingh77/multi-server:$SHA
kubectl set image deployments/client-deployment client=dksingh77/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dksingh77/multi-worker:$SHA