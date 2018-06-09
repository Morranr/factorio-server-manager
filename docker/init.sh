#!/bin/sh
mkdir -p /security
if [ ! -f /security/server.key ]; then
	echo "No SSL key found. generating new key and certificate"
	openssl req \
		-new \
		-newkey rsa:2048 \
		-days 365 \
		-nodes\
		-x509 \
		-subj "/CN=localhost" \
		-keyout /security/server.key \
		-out /security/server.crt
fi

curl -s -L -S -k https://www.factorio.com/get-download/latest/headless/linux64 -o /tmp/factorio_latest.tar.xz
tar Jxf /tmp/factorio_latest.tar.xz
rm /tmp/factorio_latest.tar.xz

nohup nginx &
cd /opt/factorio-server-manager
./factorio-server-manager -dir '/opt/factorio'
