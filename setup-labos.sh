#!/usr/bin/env bash

LOCALBIN="$HOME/.local/bin"
TMP="$HOME/.local/tmp"
DIRDESCARGA="/media/libre/ssoo-talleres"

mkdir -p "$LOCALBIN"
mkdir -p "$TMP"
mkdir -p "$DIRDESCARGA"

wget https://releases.hashicorp.com/vagrant/2.3.0/vagrant_2.3.0_linux_amd64.zip --directory-prefix="$TMP" -N

cd "$TMP"
unzip -o vagrant_2.3.0_linux_amd64.zip
mv vagrant "$LOCALBIN"

wget https://github.com/moparisthebest/static-curl/releases/download/v7.85.0/curl-amd64 --directory-prefix="$TMP" -N
mv curl-amd64 "$LOCALBIN/curl"
chmod +x "$LOCALBIN/curl"

wget https://github.com/sistemasoperativosdcuba/talleres/raw/main/bsdtar --directory-prefix="$TMP" -N
mv bsdtar "$LOCALBIN"
chmod +x "$LOCALBIN/bsdtar"

wget https://github.com/sistemasoperativosdcuba/talleres/raw/main/talleres-box.torrent --directory-prefix="$TMP" -N
wget https://github.com/sistemasoperativosdcuba/talleres/raw/main/setup-env-talleres --directory-prefix="$TMP" -N
chmod +x setup-env-talleres

./setup-env-talleres

vagrant box add --name sistemasoperativosdcuba/talleres boxdownload/package.box

