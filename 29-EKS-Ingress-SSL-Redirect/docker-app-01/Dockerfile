# Use an existing base image
FROM nginx

# Create app1 directory
RUN mkdir -p /usr/share/nginx/html/app1

# Copy the HTML and CSS files to the app1 directory
COPY index.html style.css /usr/share/nginx/html/app1/

# Expose port 80 for web traffic
EXPOSE 80
