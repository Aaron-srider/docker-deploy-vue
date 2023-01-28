FROM ubuntu:18.04

# replace sources list to accelarate installations
COPY sources.list /etc/apt/sources.list

# install nginx
RUN apt update && apt install -y nginx

# copy nginx config file
COPY default /etc/nginx/sites-available

# this is nginx root
WORKDIR /var/www/html

# copy vue dist into container and extract it to nginx root
COPY ./dist.tar.gz .
RUN rm /var/www/html/index*
RUN tar -xf /var/www/html/dist.tar.gz
RUN mv /var/www/html/dist/* /var/www/html/

# start nginx at the beginning of the container starting
CMD ["sh", "-c", "service nginx start; while true; do sleep 1; done;"]
