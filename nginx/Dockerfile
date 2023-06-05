FROM nginx:alpine-perl

RUN apk update
RUN apk add wget nginx-mod-http-perl

RUN rm -rf /etc/nginx/conf.d 
RUN rm /etc/nginx/nginx.conf

COPY conf.d/ /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/nginx.conf

COPY .htpasswd /var/www/protect/.htpasswd

RUN mkdir -p /usr/local/lib/perl
COPY upload.pm /usr/local/lib/perl/upload.pm

COPY ./ssl/ /etc/nginx/ssl/
RUN chmod 600 /etc/nginx/ssl/*.key

RUN mkdir /var/www/upload
RUN chmod -R 0750 /var/www/upload
RUN mkdir /var/www/tech

WORKDIR /var/www/tech