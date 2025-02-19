#!/bin/bash

NGINX_TEMPLATES_DIR=./templates

NGINX_CONF=default.conf.template
NGINX_CERT=$NGINX_TEMPLATES_DIR/nginx-selfsigned.crt
NGINX_CERT_KEY=$NGINX_TEMPLATES_DIR/nginx-selfsigned.key

# If templates dir is not exist, create it.
if [ ! -d "$NGINX_TEMPLATES_DIR" ]; then
  mkdir -p "$NGINX_TEMPLATES_DIR"
fi

# Generate HTTPS certification and private key files.
openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -keyout $NGINX_CERT_KEY -out $NGINX_CERT

# Install NGINX configuration if not exist
# If configuration is exist, skip it.
if [ ! -e $NGINX_TEMPLATES_DIR/$NGINX_CONF ]; then
  cp $NGINX_CONF $NGINX_TEMPLATES_DIR/$NGINX_CONF
fi
