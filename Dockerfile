FROM alpine:latest

RUN apk add --no-cache supervisor bind-tools iptables sniproxy dnsmasq && mkdir -p /opt/tariq

ADD services.ini /etc/supervisor.d/
ADD instl /usr/local/bin/
WORKDIR /opt/tariq
COPY . .

#ADD my_init /
CMD ["/opt/tariq/my_init"]
