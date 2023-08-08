## About

Tariq is yet another smart DNS solution to bypass geo-blocking.

## Prerequisites

* Docker ([Install](https://docs.docker.com/engine/install/ubuntu/))
* systemd
* BASH v4
* crontab
* dig
* iptables
* Open ports: 53, 80, 443
* Open ports (IF Encrypt Enable): 53, 80, 443 , 853, 4443
* A domain and ssl for it (IF Encrypt Enable)

## Installation

```bash
sudo git clone https://github.com/alikhadivi/tariq /opt/tariq
cd /opt/tariq
sudo git submodule init
sudo git submodule update
sudo ln -snf /opt/tariq/tariq /usr/bin/tariq
sudo tariq pull
```

## Usage

Tariq needs to be installed on a server to the region you are interested.
After you start it, change the DNS of client to the IP of your server.

## Enable With Encryption
```bash
sudo tariq config-set encrypt true
```
create `.env` file with below content and set your ssl path:
```
cert=/path/to/cert.pem
key=/path/to/key.pem
```
After:
```bash
sudo tariq start
sudo tariq enable
sudo docker compose up -d --build
```

### Start Tariq and enable it on boot

```bash
sudo tariq start
sudo tariq enable
```
**Note:** Required to enable cronjob after install

### Check if it's running

```bash
sudo tariq status
```

### Enable Cronjob
Enable cronjob for auto reload ddns ips(Required):
```bash
sudo tariq cronjob
```

### Allow an IP to use your smart DNS

```bash
sudo tariq add-ip 1.2.3.4
```

### Remove an IP

```bash
sudo tariq rm-ip 1.2.3.4
```

### List all allowed IPs

```bash
sudo tariq list-ips
```

### Allow an DDNS Client to use your smart DNS

```bash
sudo tariq add-ddns mypc.example.com
```

### Remove an DDNS Client

```bash
sudo tariq rm-ddns mypc.example.com
```

### List all allowed DDNS Client

```bash
sudo tariq list-ddns
```

### Update DDNS Client IP

```bash
sudo tariq reload-ddns
```

### Update Tariq
```bash
sudo tariq update
```
OR
```bash
cd /otp/tariq
sudo git pull
sudo git submodule update
sudo tariq pull
sudo tariq restart
```

### Configuration

If you want to use OpenDNS servers instead Google DNS then do:

```bash
sudo tariq config-set dns '208.67.222.222,208.67.220.220'
sudo tariq restart
```

Tariq by default is using iptables to allow ports `443`, `80`, `53`
only for the IPs you want. If you prefer to manage this with your own
firewall rules, then you can disable this feature with:

```bash
sudo tariq config-set iptables false
sudo tariq restart
```

<!-- Tariq detects if you have a global IPv6 and it creates IPv6 NAT. This
feature adds an iptables rule even if `iptables` config options is `false`.
To disable this feature do:

```bash
sudo tariq config-set ipv6nat false
sudo tariq restart
``` -->
