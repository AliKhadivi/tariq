FROM nginx:alpine

RUN rm -f /etc/nginx/nginx.conf \
    && rm -f /etc/nginx/conf.d/default.conf
COPY ./nginx/ /etc/nginx/
EXPOSE 4443 853