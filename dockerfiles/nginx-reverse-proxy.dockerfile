FROM nginx:stable-alpine

#  default conf for proxy service
COPY ./configs/nginx/default.conf /etc/nginx/conf.d/default.conf
# Proxy configurations
COPY ./configs/nginx/proxy.conf /etc/nginx/includes/

EXPOSE 80




