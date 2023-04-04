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

wget --directory-prefix="$TMP" -N https://github.com/sistemasoperativosdcuba/vm-talleres/raw/main/bsdtar
cp bsdtar "$LOCALBIN"
chmod +x "$LOCALBIN/bsdtar"

# ADD $LOCALBIN to .bashrc
export PATH="$LOCALBIN:$PATH"
if ! grep -q 'PATH="'$LOCALBIN':$PATH"' $HOME/.bashrc; then
    echo 'PATH="'$LOCALBIN':$PATH"' >> $HOME/.bashrc
fi

wget --directory-prefix="$TMP" -N https://github.com/sistemasoperativosdcuba/vm-talleres/raw/main/talleres-box.torrent
wget --directory-prefix="$TMP" -N https://github.com/sistemasoperativosdcuba/vm-talleres/raw/main/setup-env-talleres
chmod +x setup-env-talleres

pkill --full ./setup-env-talleres || true
./setup-env-talleres

wget --directory-prefix="$TMP" -N https://github.com/sistemasoperativosdcuba/vm-talleres/raw/main/labo-box-metadata.json
$LOCALBIN/vagrant box add --force labo-box-metadata.json

# Dejar seedeando por algunas horas en background
pkill --full ./setup-env-talleres || true
nohup ./setup-env-talleres --seeder > /dev/null &

cd "$PROYECTO"
# Elimino viejo Vagrantfile, mejor que usen el del repo
rm -f Vagrantfile || true

if ! git clone "https://github.com/sistemasoperativosdcuba/talleres.git" "${REPO_TALLERES}" 2>/dev/null && [ -d "${REPO_TALLERES}" ] ; then
    echo "Falló el git clone del proyecto de los talleres. Intentaremos hacer un pull..."
    cd $REPO_TALLERES
    if git pull ; then
        echo "Repositorio de talleres actualizado."
    else
        echo "ERROR al intentar actualizar el repositorio de talleres. Fijate de clonar el repositorio en ~/${REPO_TALLERES}"
    fi
fi


echo ""
echo ""
echo ""
echo ""


echo -e "\e[32m"
echo "---------------------------------------------------------------"
echo "        INSTRUCCIONES: LEE ATENTAMENTE LO SIGUIENTE:           "
echo "---------------------------------------------------------------"
echo -e "\e[33m"
echo "Andá primero al directorio donde está el repo de talleres con el siguiente comando:"
echo "cd ~${REPO_TALLERES}"
echo "Luego, entrá a la carpeta del taller correspondiente (ejemplo taller3-drivers)"
echo ""
echo "Una vez ahí, podés ejecutar el comando 'vagrant up', esperar un poco a que la VM levante, y luego 'vagrant ssh' para abrir una consola en la VM."
echo "Los archivos que coloques en el directorio $PROYECTO los podrás acceder desde dentro de la VM en el directorio /vagrant"
echo "Antes de irte del labo, corré 'vagrant destroy' para liberar los recursos de la VM"

echo -e "\e[31m"
echo ""
echo ""
echo "--------------------------------------------------------------"
echo "            PARA TERMINAR LA INSTALACIÓN DEBERÁS              "
echo "           CERRAR LA TERMINAL Y ABRIRLA NUEVAMENTE            "
echo "        >>>>>>> ACORDATE LAS INSTRUCCIONES <<<<<<<<<<         "
echo "--------------------------------------------------------------"
echo ""

