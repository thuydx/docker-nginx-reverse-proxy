#!/bin/sh
set -e

echo "[INFO] nginx-proxy entrypoint starting..."

# ----------------------------------------------------------------------
# Render nginx-proxy.conf using environment variables
# ----------------------------------------------------------------------
TEMPLATE="/etc/nginx/conf.d/nginx-proxy.conf"
RENDERED="/etc/nginx/conf.d/nginx-proxy.conf.rendered"

if [ ! -f "$TEMPLATE" ]; then
  echo "[ERROR] Template not found: $TEMPLATE"
  exit 1
fi

echo "[INFO] Rendering nginx-proxy.conf with envsubst..."
envsubst < "$TEMPLATE" > "$RENDERED"
mv "$RENDERED" "$TEMPLATE"

# ----------------------------------------------------------------------
# Validate nginx configuration before start
# ----------------------------------------------------------------------
echo "[INFO] Validating nginx configuration..."
nginx -t

# ----------------------------------------------------------------------
# Start nginx in foreground (Docker best practice)
# ----------------------------------------------------------------------
echo "[INFO] Starting nginx..."
exec nginx -g "daemon off;"
