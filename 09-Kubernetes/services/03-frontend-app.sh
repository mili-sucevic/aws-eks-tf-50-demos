#!/bin/bash

# Create Deployment for Frontend Nginx App
kubectl create deployment my-frontend-nginx-app --image=milisucevic/kube-front-end-nginx:2.0.0 
kubectl get deploy
echo

# Create ClusterIp Service for Frontend Nginx App
kubectl expose deployment my-frontend-nginx-app  --type=NodePort --port=80 --target-port=80 --name=my-frontend-service
kubectl get svc
echo

# Define kubernetes variables
kubectl get nodes -o wide
node_ip=$(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="ExternalIP")].address}' | awk '{print $1}')
service=$(kubectl get svc --selector=app=my-frontend-nginx-app --output=jsonpath={.items[0].metadata.name})
node_port=$(kubectl get svc $service -o jsonpath='{.spec.ports[*].nodePort}')
backend_deploy=$(kubectl get deploy --selector=app=my-backend-rest-app --output=jsonpath={.items[0].metadata.name})
pod=$(kubectl get pods --selector=app=my-frontend-nginx-app --no-headers=true | shuf -n 1 | awk '{print $1}')
echo

# Capture IP and Port to Access Application
echo "Capture IP and Port to Access Application:"
kubectl exec -it $pod -- curl http://$node_ip:$node_port/hello
echo
kubectl exec -it $pod -- curl http://$node_ip:$node_port/hello
echo
kubectl exec -it $pod -- curl http://$node_ip:$node_port/hello
echo
kubectl exec -it $pod -- curl http://$node_ip:$node_port/hello
echo
kubectl exec -it $pod -- curl http://$node_ip:$node_port/hello
echo

# Scale backend with 10 replicas
echo
echo "Scale backend with 10 replicas:"
kubectl scale --replicas=10 deployment/$backend_deploy
sleep 10
echo
kubectl get po -o wide
sleep 10
echo
kubectl get rs
echo

# Test again to view the backend service Load Balancing
echo "Test again to view the backend service Load Balancing:"
kubectl exec -it $pod -- curl http://$node_ip:$node_port/hello
echo
kubectl exec -it $pod -- curl http://$node_ip:$node_port/hello
echo
kubectl exec -it $pod -- curl http://$node_ip:$node_port/hello
echo
kubectl exec -it $pod -- curl http://$node_ip:$node_port/hello
echo
kubectl exec -it $pod -- curl http://$node_ip:$node_port/hello
echo

# # Output all vars
# echo "The public IP a node is: $node_ip"
# echo "The name of the frontend service is: $service"
# echo "The frontend node port is: $node_port"
# echo "The name of the backend deployment is: $backend_deploy"
# echo "The name of the frontend pod is: $pod"
# echo

