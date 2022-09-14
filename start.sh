#!/bin/bash

echo "start minikube 2 cpus 2200mb"
echo "---------------------------"
minikube start --cpus 2 --memory=2200mb

echo "create deployment httpd sample"
echo "---------------------------"
kubectl create deployment httpd --image=httpd --port=80

echo "waiting the pod with status Running"
echo "---------------------------"
for podname in $(kubectl get pods $podname  -o json | jq -r ' select(.status.conditions[].type == "Running") | .status.conditions[].type ')
do
kubectl get pods $podname  -o json | jq -r ' select(.status.conditions[].type == "Running") | .status.conditions[].type ' | grep -x Running
done

echo "expose httpd sample"
echo "---------------------------"
kubectl expose deployment httpd  

echo "port-forward service httpd for open preview on port 8080"
echo "---------------------------"
kubectl port-forward service/httpd 8080:80  

