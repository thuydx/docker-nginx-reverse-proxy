FROM nginx:1.25

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

# Copy reverse proxy config
COPY ./config/proxy.conf /etc/nginx/conf.d/proxy.conf

EXPOSE 80
