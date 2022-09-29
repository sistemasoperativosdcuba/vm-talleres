#!/usr/bin/env bash

LOCALBIN="$HOME/.local/bin"
TMP="$HOME/.local/tmp"
PROYECTO="$HOME/ssoo-talleres"
REPO_TALLERES="$PROYECTO/repo"

# exit when any command fails
set -e

mkdir -p "$LOCALBIN"
mkdir -p "$TMP"
mkdir -p "$PROYECTO"
mkdir -p "$REPO_TALLERES"

wget --directory-prefix="$TMP" --continue https://releases.hashicorp.com/vagrant/2.3.0/vagrant_2.3.0_linux_amd64.zip

cd "$TMP"
unzip -o vagrant_2.3.0_linux_amd64.zip
cp vagrant "$LOCALBIN"

wget --directory-prefix="$TMP" --continue https://github.com/moparisthebest/static-curl/releases/download/v7.85.0/curl-amd64
cp curl-amd64 "$LOCALBIN/curl"
chmod +x "$LOCALBIN/curl"

wget --directory-prefix="$TMP" --continue https://github.com/sistemasoperativosdcuba/vm-talleres/raw/main/bsdtar
cp bsdtar "$LOCALBIN"
chmod +x "$LOCALBIN/bsdtar"

wget --directory-prefix="$TMP" --continue https://github.com/sistemasoperativosdcuba/vm-talleres/raw/main/talleres-box.torrent
wget --directory-prefix="$TMP" --continue https://github.com/sistemasoperativosdcuba/vm-talleres/raw/main/setup-env-talleres
chmod +x setup-env-talleres

pkill setup-env-talleres || true
./setup-env-talleres

wget --directory-prefix="$TMP" --continue https://github.com/sistemasoperativosdcuba/vm-talleres/raw/main/labo-box-metadata.json
vagrant box add --force labo-box-metadata.json

# Dejar seedeando por algunas horas en background
pkill setup-env-talleres || true
nohup ./setup-env-talleres --seeder > /dev/null &

cd "$PROYECTO"
wget -O Vagrantfile https://github.com/sistemasoperativosdcuba/vm-talleres/raw/main/Vagrantfile-labos

if ! git clone "https://github.com/sistemasoperativosdcuba/talleres" "${REPO_TALLERES}" 2>/dev/null && [ -d "${REPO_TALLERES}" ] ; then
    echo "Falló el git clone del proyecto de los talleres."
fi

echo "Listo. Podés ejecutar el comando 'vagrant up' y luego 'vagrant ssh' para abrir una consola en la VM."
echo "Los archivos que coloques en el directorio $PROYECTO los podrás acceder desde dentro de la VM en el directorio /vagrant"
