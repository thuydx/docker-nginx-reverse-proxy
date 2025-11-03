FROM nginx:1.25

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

# Copy main config
COPY ./config/nginx.conf /etc/nginx/nginx.conf
# Copy reverse proxy config
COPY ./config/nginx.proxy.settings /etc/nginx/nginx.proxy.settings
COPY ./config/nginx-proxy.conf /etc/nginx/conf.d/nginx-proxy.conf

EXPOSE 80
