FROM alpine

RUN apk add --no-cache supervisor bind-tools iptables sniproxy dnsmasq

ADD instl /usr/local/bin/
RUN mkdir -p /opt/tariq
ADD dnsmasq.sh sniproxy.sh domains tariq /opt/tariq/

ADD services.ini /etc/supervisor.d/
ADD my_init /
CMD ["/my_init"]
