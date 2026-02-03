FROM nginx:1.29.4

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

# Copy main config
COPY ./config/nginx.conf /etc/nginx/nginx.conf
# Copy reverse proxy config
COPY ./config/nginx.proxy.settings /etc/nginx/nginx.proxy.settings
COPY ./config/nginx-proxy.conf /etc/nginx/conf.d/nginx-proxy.conf

COPY ./config/ssl/rootCA.pem /usr/local/share/ca-certificates/mkcert-rootCA.crt
RUN update-ca-certificates

EXPOSE 80
