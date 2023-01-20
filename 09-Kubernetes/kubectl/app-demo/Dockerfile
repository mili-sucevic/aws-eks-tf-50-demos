FROM nginx:latest
COPY default.conf /etc/nginx/conf.d/
RUN apt-get update && apt-get install -y curl && apt-get clean
CMD ["nginx", "-g", "daemon off;"]
