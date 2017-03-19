FROM nginx:alpine

VOLUME [ "/etc/nginx/sites-enabled" ]

ADD ssl.inc /etc/nginx/
ADD run.sh /

RUN apk add --no-cache bash certbot && chmod +x /run.sh


CMD [ "run.sh" ]

