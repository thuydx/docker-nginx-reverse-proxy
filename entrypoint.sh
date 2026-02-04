#!/bin/sh
set -e

echo "[INFO] nginx-proxy entrypoint starting..."

TEMPLATE="/etc/nginx/conf.d/nginx-proxy.conf"
RENDERED="/etc/nginx/conf.d/nginx-proxy.runtime.conf"

if [ ! -f "$TEMPLATE" ]; then
  echo "[ERROR] Template not found: $TEMPLATE"
  exit 1
fi

echo "[INFO] Rendering nginx-proxy.conf with envsubst..."
envsubst < "$TEMPLATE" > "$RENDERED"

# ----------------------------------------------------------------------
# Validate nginx configuration using rendered file
# ----------------------------------------------------------------------
echo "[INFO] Validating nginx configuration..."
#nginx -t

# ----------------------------------------------------------------------
# Start nginx
# ----------------------------------------------------------------------
echo "[INFO] Starting nginx..."
exec nginx -g "daemon off;"
