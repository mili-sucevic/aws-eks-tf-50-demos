#!/bin/bash

# Create a new directory for the project
mkdir app-demo
cd app-demo

# Create a new default.conf file for nginx
touch default.conf
echo "server {
    listen       80;
    server_name  localhost;

    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;

    #location / {
    #   root   /usr/share/nginx/html;
    #    index  index.html index.htm;
    #}

    location / {
    # Update your backend application Kubernetes Cluster-IP Service name  and port below
    # proxy_pass http://<Backend-ClusterIp-Service-Name>:<Port>;  
    proxy_pass http://my-backend-service:8080;
    }

    #error_page  404              /404.html;
    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}" > default.conf

# Create a new Dockerfile
touch Dockerfile
echo "FROM nginx:latest
COPY default.conf /etc/nginx/conf.d/
CMD [\"nginx\", \"-g\", \"daemon off;\"]" > Dockerfile

# Build the Docker image
docker build -t milisucevic/kube-front-end-nginx:1.0.0 .

# Push Docker Image to Docker Hub
docker push milisucevic/kube-front-end-nginx:1.0.0 
