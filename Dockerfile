FROM thuydx/nginx:1.29

LABEL maintainer="Thuy Dinh <thuydx@zendgroup.vn>" \
      author="Thuy Dinh" \
      description="Nginx reverse proxy"

# Remove default nginx config (safe)
RUN rm -f /etc/nginx/conf.d/default.conf

# Copy global nginx config
COPY ./config/nginx.conf /etc/nginx/nginx.conf

# Copy proxy shared settings
COPY ./config/nginx.proxy.settings /etc/nginx/nginx.proxy.settings

# Copy reverse proxy vhost template
COPY ./config/nginx-proxy.conf /etc/nginx/conf.d/nginx-proxy.conf

# ---- Internal CA (mkcert / internal TLS) ----
COPY ./config/ssl/rootCA.pem /usr/local/share/ca-certificates/mkcert-rootCA.crt
RUN update-ca-certificates

# Entrypoint (envsubst + nginx start)
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose public ports
EXPOSE 80 443

# Entrypoint handles nginx startup
ENTRYPOINT ["/entrypoint.sh"]
