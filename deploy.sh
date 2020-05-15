docker build -t nathant27/multi-client:latest -t nathant27/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nathant27/multi-server:latest -t nathant27/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nathant27/multi-worker:latest -t nathant27/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push nathant27/multi-client:latest
docker push nathant27/multi-server:latest
docker push nathant27/multi-worker:latest

docker push nathant27/multi-client:$SHA
docker push nathant27/multi-server:$SHA
docker push nathant27/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nathant27/multi-server:SHA
kubectl set image deployments/client-deployment client=nathant27/multi-client:SHA
kubectl set image deployments/worker-deployment worker=nathant27/multi-worker:SHA