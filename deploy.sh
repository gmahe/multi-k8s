docker build -t gmahe/multi-client:latest gmahe/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t gmahe/multi-server:latest gmahe/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t gmahe/multi-worker:latest gmahe/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push gmahe/multi-client:latest
docker push gmahe/multi-client:$SHA

docker push gmahe/multi-server:latest
docker push gmahe/multi-server:$SHA

docker push gmahe/multi-worker:latest
docker push gmahe/multi-worker:$SHA

kubctl apply -f k8s
kubctl set image deployments/server-deployment server=gmahe/multi-server:$SHA
kubctl set image deployments/client-deployment client=gmahe/multi-client:$SHA
kubctl set image deployments/worker-deployment worker=gmahe/multi-worker:$SHA
