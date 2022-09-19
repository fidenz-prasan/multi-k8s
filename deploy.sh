docker build -t nimanthaprasan/multi-client:latest -t nimanthaprasan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nimanthaprasan/multi-server:latest -t nimanthaprasan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nimanthaprasan/multi-worker:latest -t nimanthaprasan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nimanthaprasan/multi-client:latest
docker push nimanthaprasan/multi-server:latest
docker push nimanthaprasan/multi-worker:latest

docker push nimanthaprasan/multi-client:$SHA
docker push nimanthaprasan/multi-server:$SHA
docker push nimanthaprasan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=nimanthaprasan/multi-server:$SHA
kubectl set image deployment/client-deployment client=nimanthaprasan/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=nimanthaprasan/multi-worker:$SHA