#!/bin/bash

# Create Deployment for Frontend Nginx App
kubectl create deployment my-frontend-nginx-app --image=milisucevic/kube-front-end-nginx:1.0.0 
kubectl get deploy
echo

# Create ClusterIp Service for Frontend Nginx App
kubectl expose deployment my-frontend-nginx-app  --type=NodePort --port=80 --target-port=80 --name=my-frontend-service
kubectl get svc
echo

# Capture IP and Port to Access Application
kubectl get nodes -o wide
node_ip=$(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="ExternalIP")].address}' | awk '{print $1}')
service=$(kubectl get svc --selector=app=my-frontend-nginx-app --output=jsonpath={.items[0].metadata.name})
node_port=$(kubectl get svc $service -o jsonpath='{.spec.ports[*].nodePort}')
deploy=$(kubectl get deploy --selector=app=my-frontend-nginx-app --output=jsonpath={.items[0].metadata.name})
echo

# Scale backend with 10 replicas
kubectl scale --replicas=10 deployment/$deploy
echo
kubectl get po -o wide
echo
kubectl get rs
echo

# Output t
echo "The public IP a node is: $node_ip"
echo "The name of the frontend service is: $service"
echo "The frontend node port is: $node_port"
echo "The name of the frontend deployment is: $deploy"
echo

