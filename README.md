# DOCKER DANTE OPENVPN SOCKS5 GATEWAY

Spin up a VPN gateway. Works great with  https://github.com/dlaub3/bloody-tears-of-dns-madness

This configuration also proxies DNS queries since dante and openvpn share `/dev/net/tun` and `/etc/resolv.conf`.

```
docker exec -ti ovpn cat /etc/resolv.conf
docker exec -ti dante cat /etc/resolv.conf
```
If you use https://github.com/dlaub3/bloody-tears-of-dns-madness you'll be able to run:
`HTTPS_PROXY=socks5h://gateway.docker curl https://ifconfig.me`

Otherwise you'll likely want to add a host port mapping to docker-compose.yaml

https://ifconfig.me
https://dnsleaktest.com
