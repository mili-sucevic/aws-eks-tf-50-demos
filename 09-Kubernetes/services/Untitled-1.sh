#!/bin/bash

# Create a new directory for the project
mkdir app-demo
cd app-demo

# Create a new default.conf file for nginx
touch default.conf
echo "server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html index.htm;
    }
}" > default.conf

# Create a new Dockerfile
touch Dockerfile
echo "FROM nginx:latest
COPY default.conf /etc/nginx/conf.d/
CMD [\"nginx\", \"-g\", \"daemon off;\"]" > Dockerfile

# Build the Docker image
docker build -t mynginx .

# Run the container
docker run -p 80:80 mynginx