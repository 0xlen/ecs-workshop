FROM amazonlinux:latest
MAINTAINER Eason Cao (yangxinc@amazon.com)

# Install python and pip
RUN yum update -y
RUN yum install -y nginx

# Copy local index.html into container
COPY index.html /usr/share/nginx/html/

# run the nginx
CMD ["nginx", "-g", "daemon off;"]
