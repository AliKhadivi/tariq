## About

Tariq is yet another smart DNS solution to bypass geo-blocking.

## Dependencies

* Docker ([Install](https://docs.docker.com/engine/install/ubuntu/))
* systemd
* BASH v4
* crontab
* dig
<!-- * iptables & ipset -->
<!-- ## Install iptables & ipset on debian based 
```bash
sudo apt install iptables ipset
``` -->
<!-- 
## Install from DockerHub

```bash
docker pull alikhadivi/tariq
docker run -v /usr/local/bin:/install alikhadivi/tariq instl
``` -->

## Installation

```bash
cd /opt
git clone https://github.com/alikhadivi/tariq
cd tariq
docker pull alikhadivi/tariq
ln -snf $PWD/tariq /usr/local/bin/tariq
```

## Enable Cronjob
```bash
/opt/tariq/crontab.sh
```

## Usage

Tariq needs to be installed on a server to the region you are interested.
After you start it, change the DNS of client to the IP of your server.

### Start Tariq and enable it on boot

```bash
tariq start
tariq enable
```

### Check if it's running

```bash
tariq status
```

### Allow an IP to use your smart DNS

```bash
tariq add-ip 1.2.3.4
```

### Remove an IP

```bash
tariq rm-ip 1.2.3.4
```

### List all allowed IPs

```bash
tariq list-ips
```

### Allow an DDNS Client to use your smart DNS

```bash
tariq add-ddns mypc.example.com
```

### Remove an DDNS Client

```bash
tariq rm-ddns mypc.example.com
```

### List all allowed DDNS Client

```bash
tariq list-ddns
```

### Update DDNS Client IP

```bash
tariq reload-ddns
```

### Configuration

If you want to use OpenDNS servers instead Google DNS then do:

```bash
tariq config-set dns '208.67.222.222,208.67.220.220'
tariq restart
```

Tariq by default is using iptables to allow ports `443`, `80`, `53`
only for the IPs you want. If you prefer to manage this with your own
firewall rules, then you can disable this feature with:

```bash
tariq config-set iptables false
tariq restart
```

Tariq detects if you have a global IPv6 and it creates IPv6 NAT. This
feature adds an iptables rule even if `iptables` config options is `false`.
To disable this feature do:

```bash
tariq config-set ipv6nat false
tariq restart
```

## License
MIT
