docker build -t gmahe/multi-client:latest -t gmahe/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gmahe/multi-server:latest -t gmahe/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gmahe/multi-worker:latest -t gmahe/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gmahe/multi-client:latest
docker push gmahe/multi-client:$SHA

docker push gmahe/multi-server:latest
docker push gmahe/multi-server:$SHA

docker push gmahe/multi-worker:latest
docker push gmahe/multi-worker:$SHA

kubectl apply -f k8s

# Used to tell now we use this new version
kubectl set image deployments/server-deployment server=gmahe/multi-server:$SHA
kubectl set image deployments/client-deployment client=gmahe/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gmahe/multi-worker:$SHA
