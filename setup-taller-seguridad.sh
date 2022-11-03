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

cd "$TMP"

wget --directory-prefix="$TMP" --continue https://github.com/sistemasoperativosdcuba/vm-talleres/raw/main/so-labo-seginf.torrent
wget --directory-prefix="$TMP" --continue https://github.com/sistemasoperativosdcuba/vm-talleres/raw/main/setup-env-talleres
chmod +x setup-env-talleres

pkill --full ./setup-env-talleres || true
./setup-env-talleres --torrent so-labo-seginf.torrent

# Dejar seedeando por algunas horas en background
pkill --full ./setup-env-talleres || true
nohup ./setup-env-talleres --seeder --torrent so-labo-seginf.torrent > /dev/null &

VBoxManage import so-labo-seginf.ova

echo "Listo. Abrí VirtualBox y prendé la VM so-labo-seginf."
echo "Antes de irte del labo, eliminá la VM para liberar espacio."
