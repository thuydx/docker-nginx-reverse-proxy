FROM thuydx/nginx:1.29

LABEL maintainer="Thuy Dinh <thuydx@zendgroup.vn>" \
      author="Thuy Dinh" \
      description="Nginx reverse proxy"

# Remove default nginx config (safe)
RUN rm -f /etc/nginx/conf.d/default.conf
RUN rm -f /etc/nginx/conf.d/nginx-proxy.conf
RUN rm -f /etc/nginx/conf.d/nginx-proxy.runtime.conf

# Copy global nginx config
COPY ./config/nginx.conf /etc/nginx/nginx.conf

# Copy proxy shared settings
COPY ./config/nginx.proxy.settings /etc/nginx/nginx.proxy.settings

# Copy reverse proxy vhost template
# COPY ./config/nginx-proxy.conf /etc/nginx/conf.d/nginx-proxy.conf
COPY ./config/nginx-proxy.conf /etc/nginx/templates/nginx-proxy.conf

# ---- Internal CA (mkcert / internal TLS) ----
COPY ./config/ssl/rootCA.pem /usr/local/share/ca-certificates/mkcert-rootCA.crt
# Copy default TLS certs for acp.labs.local
COPY ./config/ssl/acp.labs.local.crt /etc/nginx/ssl/acp.labs.local.crt
COPY ./config/ssl/acp.labs.local.key /etc/nginx/ssl/acp.labs.local.key
# Copy default TLS certs for api.labs.local
COPY ./config/ssl/api.labs.local.crt /etc/nginx/ssl/api.labs.local.crt
COPY ./config/ssl/api.labs.local.key /etc/nginx/ssl/api.labs.local.key
COPY ./config/ssl/api.labs.local.pem /etc/nginx/ssl/api.labs.local.pem
COPY ./config/ssl/api.labs.local-key.pem /etc/nginx/ssl/api.labs.local-key.pem
# Update CA certificates
RUN update-ca-certificates

# Entrypoint (envsubst + nginx start)
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose public ports
EXPOSE 80 443

# Entrypoint handles nginx startup
ENTRYPOINT ["/entrypoint.sh"]
