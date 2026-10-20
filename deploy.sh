docker build -t holykens/multi-client:latest -t holykens/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t holykens/multi-server:latest -t holykens/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t holykens/multi-worker:latest -t holykens/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push holykens/multi-client:latest
docker push holykens/multi-server:latest
docker push holykens/multi-worker:latest

docker push holykens/multi-client:$SHA
docker push holykens/multi-server:$SHA
docker push holykens/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=holykens/multi-server:$SHA
kubectl set image deployments/client-deployment client=holykens/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=holykens/multi-worker:$SHA