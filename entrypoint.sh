envsubst < /etc/nginx/conf.d/nginx-proxy.conf > /etc/nginx/conf.d/nginx-proxy.conf.rendered
mv /etc/nginx/conf.d/nginx-proxy.conf.rendered /etc/nginx/conf.d/nginx-proxy.conf
