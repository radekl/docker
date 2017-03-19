#!/usr/bin/env bash

if [[ "x$1" != "xrenew" ]]; then

  ## Check env vars
  if [ -z ${CERTBOT_MAIL} ]; then
    echo "Error: Must provide an email CERTBOT_MAIL"; 
    exit 1; 
  fi
  if [ -z ${CERTBOT_DOMAINS} ]; then 
    echo "Error: Must provide domain(s) CERTBOT_DOMAINS"; 
    exit 2; 
  fi

  ## Actually do the job
  if [ -z ${CERTBOT_DISTINCT} ]; then
    certbot certonly -n --agree-tos -m="${CERTBOT_MAIL}" --webroot -w "/usr/share/nginx/html" -d "${CERTBOT_DOMAINS}"; 
  else
    IFS=',' read -ra DOMAIN_ARRAY <<< "${domains}"
    for domain in "${DOMAIN_ARRAY[*]}"; do
      certbot certonly -n --agree-tos -m="${CERTBOT_MAIL}" --webroot -w "/usr/share/nginx/html" -d "${domain}"; 
    done

  fi
  # Run nginx 
  exec nginx -g 'daemon off;'
else
  # Just if we want to renew
  certbot renew
fi
