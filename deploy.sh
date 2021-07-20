docker build -t rakesh0docker/multi-client:latest -t rakesh0docker/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t rakesh0docker/multi-server:latest -t rakesh0docker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rakesh0docker/multi-worker:latest -t rakesh0docker/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rakesh0docker/multi-client:latest
docker push rakesh0docker/multi-server:latest
docker push rakesh0docker/multi-worker:latest
docker push rakesh0docker/multi-client:$SHA
docker push rakesh0docker/multi-server:$SHA
docker push rakesh0docker/multi-worker:$SHA
kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=rakesh0docker/multi-server:$SHA
kubectl set image deployments/client-deployment client=rakesh0docker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rakesh0docker/multi-worker:$SHA