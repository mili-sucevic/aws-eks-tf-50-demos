#!/bin/bash

# Define the namespace
# kubectl get deployment my-deployment -o jsonpath='{.metadata.namespace}'
namespace=default

# Delete all pods
echo "Deleting pods..."
kubectl delete pods -n $namespace --all

# Delete all services
echo "Deleting services..."
kubectl delete services -n $namespace --all

# Delete all deployments
echo "Deleting deployments..."
kubectl delete deployments -n $namespace --all

# Delete all statefulsets
kubectl delete statefulsets -n $namespace --all

# Delete all daemonsets
echo "Deleting daemonsets..."
kubectl delete daemonsets -n $namespace --all

# Delete all replicasets
echo "Deleting replicasets..."
kubectl delete replicasets -n $namespace --all

# Delete all jobs
echo "Deleting jobs..."
kubectl delete jobs -n $namespace --all

# Delete all cronjobs
echo "Deleting cronjobs..."
kubectl delete cronjobs -n $namespace --all

# Delete all configmaps
echo "Deleting configmaps..."
kubectl delete configmaps -n $namespace --all

# Delete all secrets
echo "Deleting secrets..."
kubectl delete secrets -n $namespace --all

# Delete all persistentvolumes
echo "Deleting persistentvolumes..."
kubectl delete persistentvolumes -n $namespace --all

# Delete all persistentvolumeclaims
echo "Deleting persistentvolumeclaims..."
kubectl delete persistentvolumeclaims -n $namespace --all

