docker build -t rakesh-gitid/multi-client:latest rakesh-gitid/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t rakesh-gitid/multi-server:latest rakesh-gitid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rakesh-gitid/multi-worker:latest rakesh-gitid/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rakesh-gitid/multi-client:latest
docker push rakesh-gitid/multi-server:latest
docker push rakesh-gitid/multi-worker:latest
docker push rakesh-gitid/multi-client:$SHA
docker push rakesh-gitid/multi-server:$SHA
docker push rakesh-gitid/multi-worker:$SHA
kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=rakesh-gitid/multi-server:$SHA
kubectl set image deployments/client-deployment server=rakesh-gitid/multi-client:$SHA
kubectl set image deployments/worker-deployment server=rakesh-gitid/multi-worker:$SHA