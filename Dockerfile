# Author: Ali Khadivi <khadiviali39@gmail.com>
FROM golang:alpine AS doh-build
LABEL MAINTAINER khadiviali39@gmail.com

RUN apk add --no-cache git make jq curl

WORKDIR /src

# Lets download latest version of DOH
RUN set -x ;\
    DOH_VERSION_LATEST="$(curl -s https://api.github.com/repos/m13253/dns-over-https/tags|jq -r '.[0].name')" \
    && curl -L "https://github.com/m13253/dns-over-https/archive/${DOH_VERSION_LATEST}.zip" -o doh.zip \
    && unzip doh.zip \
    && rm doh.zip \
    && cd dns-over-https* \
    && make doh-server/doh-server \
    && mkdir /dist \
    && cp doh-server/doh-server /dist/doh-server \
    && echo ${DOH_VERSION_LATEST} > /dist/doh-server.version

FROM nginx:alpine
LABEL MAINTAINER khadiviali39@gmail.com

ENV DOH_HTTP_PREFIX="/dns-query" \
    DOH_SERVER_TIMEOUT="10" \
    DOH_SERVER_TRIES="3" \
    DOH_PORT="4443" \
    DOH_SERVER_VERBOSE="false" \
    domain="example.com" \
    cert_path="/empty.pem" \
    key_path="/empty.pem" \
    dhparam_path="/empty.pem" \
    encrypt="false"

WORKDIR /opt/tariq
COPY . .

#  certbot certbot-nginx
COPY --from=doh-build /dist /server

RUN apk update \
    && apk add --no-cache supervisor bind-tools iptables sniproxy dnsmasq bash gettext \
    && echo "stream { include /etc/nginx/stream.d/*; }" >> /etc/nginx/nginx.conf \
    && mkdir -p /etc/nginx/stream.d/ /etc/nginx/stream.templates.d/ /etc/nginx/http.templates.d/ /etc/supervisor.d/ \
    && cp -rf ./services.ini /etc/supervisor.d/services.ini \
    && cp -rf ./instl /usr/local/bin/ \
    && cp -rf ./stream.conf /etc/nginx/stream.templates.d/ \
    && cp -rf ./nginx-doh.conf /etc/nginx/http.templates.d/ \
    && touch /empty.pem \
    && rm -f /etc/nginx/conf.d/default.conf \
    && cp ./doh-server.template.conf /server/doh-server.template.conf \
    && chown -R nobody:nogroup /server

# ADD services.ini /etc/supervisor.d/
# ADD instl /usr/local/bin/


#ADD my_init /
CMD ["/opt/tariq/my_init"]
