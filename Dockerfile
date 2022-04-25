FROM alpine

RUN apk add --no-cache supervisor bind-tools iptables sniproxy dnsmasq && mkdir -p /opt/tariq

ADD instl /usr/local/bin/
COPY ./ /opt/tariq/

ADD services.ini /etc/supervisor.d/
ADD my_init /
CMD ["/my_init"]
