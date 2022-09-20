#!/usr/bin/env bash

LOCALBIN="$HOME/.local/bin"
TMP="$HOME/.local/tmp"
PROYECTO="$HOME/ssoo-taller3"

mkdir -p "$LOCALBIN"
mkdir -p "$TMP"
mkdir -p "$PROYECTO"

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

vagrant box add --name sistemasoperativosdcuba/talleres --box-version 0.1.0 boxdownload/package.box

cd "$PROYECTO"
wget https://github.com/sistemasoperativosdcuba/talleres/raw/main/Vagrantfile-labos -O Vagrantfile

echo "Listo. Podés ejecutar el comando 'vagrant up' y luego 'vagrant ssh' para abrir una consola en la VM."
echo "Los archivos que coloques en el directorio $PROYECTO los podrás acceder desde dentro de la VM en el directorio /vagrant"
