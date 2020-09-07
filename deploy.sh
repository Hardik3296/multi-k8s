docker build -t hardik3296/multi-client:latest -t hardik3296/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hardik3296/multi-server:latest -t hardik3296/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hardik3296/multi-worker:latest -t hardik3296/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push hardik3296/multi-client:latest
docker push hardik3296/multi-client:$SHA
docker push hardik3296/multi-server:latest
docker push hardik3296/multi-server:$SHA
docker push hardik3296/multi-worker:latest
docker push hardik3296/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hardik3296/multi-server:$SHA
kubectl set image deployments/client-deployment client=hardik3296/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hardik3296/multi-worker:$SHA