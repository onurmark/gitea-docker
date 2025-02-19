#!/bin/bash

NGINX_TEMPLATES_DIR=./templates

NGINX_CERT=$NGINX_TEMPLATES_DIR/nginx-selfsigned.crt
NGINX_CERT_KEY=$NGINX_TEMPLATES_DIR/nginx-selfsigned.key

if [ ! -d "$NGINX_TEMPLATES_DIR" ]; then
  mkdir -p "$NGINX_TEMPLATES_DIR"
fi

openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -keyout $NGINX_CERT_KEY -out $NGINX_CERT
