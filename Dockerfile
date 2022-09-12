# Author: Ali Khadivi <khadiviali39@gmail.com>
# FROM golang:alpine AS doh-build
# LABEL MAINTAINER khadiviali39@gmail.com

# RUN apk add --no-cache git make jq curl

# WORKDIR /src

# # Lets download latest version of DOH
# RUN set -x ;\
#     DOH_VERSION_LATEST="$(curl -s https://api.github.com/repos/m13253/dns-over-https/tags|jq -r '.[0].name')" \
#     && curl -L "https://github.com/m13253/dns-over-https/archive/${DOH_VERSION_LATEST}.zip" -o doh.zip \
#     && unzip doh.zip \
#     && rm doh.zip \
#     && cd dns-over-https* \
#     && make doh-server/doh-server \
#     && mkdir /dist \
#     && cp doh-server/doh-server /dist/doh-server \
#     && echo ${DOH_VERSION_LATEST} > /dist/doh-server.version

FROM alpine:latest
# FROM nginx:alpine
LABEL MAINTAINER khadiviali39@gmail.com

ENV DOH_HTTP_PREFIX="/dns-query" \
    DOH_SERVER_TIMEOUT="10" \
    DOH_SERVER_TRIES="3" \
    DOH_PORT="4443" \
    DOH_SERVER_VERBOSE="false" \
    domain="example.com" \
    cert_path="" \
    key_path="" \
    dhparam_path="" \
    encrypt="false"

WORKDIR /opt/tariq
COPY . .

#  certbot certbot-nginx
# COPY --from=doh-build /dist /server

RUN apk update \
    && apk add --no-cache supervisor bind-tools iptables sniproxy dnsmasq bash gettext \
    && chmod +x ./apps/* \
    && mkdir -p /etc/supervisor.d/ \
    && cp -rf ./apps/services.ini /etc/supervisor.d/services.ini \
    && cp -rf ./apps/instl /usr/local/bin/
        # \ && chown -R nobody:nogroup /server

    # && echo "stream { include /etc/nginx/stream.d/*; }" >> /etc/nginx/nginx.conf \
    # && mkdir -p /etc/nginx/stream.d/ /etc/nginx/stream.templates.d/ /etc/nginx/http.templates.d/  \
    # && cp -rf ./nginx/* /etc/nginx/ \
    # && rm -f /etc/nginx/conf.d/default.conf \
    # && cp -rf ./nginx/* /etc/nginx/ \
    # && rm -f /etc/nginx/conf.d/default.conf

# ADD services.ini /etc/supervisor.d/
# ADD instl /usr/local/bin/
    # && cp ./apps/doh-server.template.conf /server/doh-server.template.conf \


#ADD my_init /
CMD ["/opt/tariq/apps/my_init"]
