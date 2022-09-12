FROM nginx:alpine
LABEL MAINTAINER khadiviali39@gmail.com

RUN rm -f /etc/nginx/nginx.conf \
    && rm -f /etc/nginx/conf.d/default.conf
COPY ./nginx/ /etc/nginx/
EXPOSE 4443 853

