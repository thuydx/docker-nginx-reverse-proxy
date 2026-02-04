FROM thuydx/nginx:1.29

LABEL maintainer="Thuy Dinh <thuydx@zendgroup.vn>" \
      author="Thuy Dinh" \
      description="Nginx reverse proxy"

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

# Copy main config
COPY ./config/nginx.conf /etc/nginx/nginx.conf

# Copy proxy settings (shared include)
COPY ./config/nginx.proxy.settings /etc/nginx/nginx.proxy.settings

# Copy reverse proxy config
COPY ./config/nginx-proxy.conf /etc/nginx/conf.d/nginx-proxy.conf

# ---- Internal CA (mkcert / internal TLS) ----
COPY ./config/ssl/rootCA.pem /usr/local/share/ca-certificates/mkcert-rootCA.crt
RUN update-ca-certificates

# Expose public HTTP port
EXPOSE 80

# Run nginx in foreground (Docker best practice)
CMD ["nginx", "-g", "daemon off;"]