docker build -t roaslin/multi-client:latest -t roaslin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t roaslin/multi-server:latest -t roaslin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t roaslin/multi-worker:latest -t roaslin/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push roaslin/multi-client:latest
docker push roaslin/multi-server:latest
docker push roaslin/multi-worker:latest

docker push roaslin/multi-client:$SHA
docker push roaslin/multi-server:$SHA
docker push roaslin/multi-worker:$SHA

kubectl apply -f k8s
# imperative set latest image to object
kubectl set image deployments/server-deployment server=roaslin/multi-server:$SHA
kubectl set image deployments/client-deployment client=roaslin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=roaslin/multi-worker:$SHA
