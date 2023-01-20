#!/bin/bash

# Create Deployment for Frontend Nginx App
kubectl create deployment my-frontend-nginx-app --image=milisucevic/kube-front-end-nginx:1.0.0 
kubectl get deploy
echo

# Create ClusterIp Service for Frontend Nginx App
kubectl expose deployment my-frontend-nginx-app  --type=NodePort --port=80 --target-port=80 --name=my-frontend-service
kubectl get svc
echo