docker build -t roysha1/multi-client:latest -t roysha1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t roysha1/multi-server:latest -t roysha1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t roysha1/multi-worker:latest -t roysha1/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push roysha1/multi-client:latest
docker push roysha1/multi-server:latest
docker push roysha1/multi-worker:latest

docker push roysha1/multi-client:$SHA
docker push roysha1/multi-server:$SHA
docker push roysha1/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=roysha1/multi-client:$SHA
kubectl set image deployments/server-deployment server=roysha1/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=roysha1/multi-worker:$SHA