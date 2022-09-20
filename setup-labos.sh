#!/usr/bin/env bash

LOCALBIN="$HOME/.local/bin"
TMP="$HOME/.local/tmp"
PROYECTO="$HOME/ssoo-taller3"

mkdir -p "$LOCALBIN"
mkdir -p "$TMP"
mkdir -p "$PROYECTO"

wget --directory-prefix="$TMP" -N https://releases.hashicorp.com/vagrant/2.3.0/vagrant_2.3.0_linux_amd64.zip

cd "$TMP"
unzip -o vagrant_2.3.0_linux_amd64.zip
mv vagrant "$LOCALBIN"

wget --directory-prefix="$TMP" -N https://github.com/moparisthebest/static-curl/releases/download/v7.85.0/curl-amd64
mv curl-amd64 "$LOCALBIN/curl"
chmod +x "$LOCALBIN/curl"

wget --directory-prefix="$TMP" -N https://github.com/sistemasoperativosdcuba/talleres/raw/main/bsdtar
mv bsdtar "$LOCALBIN"
chmod +x "$LOCALBIN/bsdtar"

wget --directory-prefix="$TMP" -N https://github.com/sistemasoperativosdcuba/talleres/raw/main/talleres-box.torrent
wget --directory-prefix="$TMP" -N https://github.com/sistemasoperativosdcuba/talleres/raw/main/setup-env-talleres
chmod +x setup-env-talleres

./setup-env-talleres

wget --directory-prefix="$TMP" -N https://github.com/sistemasoperativosdcuba/talleres/raw/main/labo-box-metadata.json
vagrant box add labo-box-metadata.json

cd "$PROYECTO"
wget -O Vagrantfile https://github.com/sistemasoperativosdcuba/talleres/raw/main/Vagrantfile-labos

echo "Listo. Podés ejecutar el comando 'vagrant up' y luego 'vagrant ssh' para abrir una consola en la VM."
echo "Los archivos que coloques en el directorio $PROYECTO los podrás acceder desde dentro de la VM en el directorio /vagrant"
