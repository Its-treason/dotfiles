#!/bin/sh

set -ex

# Read info about distro e.g. ID = debian/ubuntu, VERSION_CODENAME = buster/jessie/jammy
. /etc/os-release

echo "Installing core utilities"
apt update
apt install -y --no-install-recommends curl htop git vim build-essential ca-certificates curl gnupg firefox-esr

apt install -y --no-install-recommends i3 lightdm

# Own repository
echo "Adding packages.its-treason.com repo"
mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL http://packages.its-treason.com/ui/pgp | gpg --dearmor -o /etc/apt/keyrings/packages-its-treason.gpg
echo \
	"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/packages-its-treason.gpg] \
  https://packages.its-treason.com "${VERSION_CODENAME}" main" |
	tee /etc/apt/sources.list.d/packages-its-treason.list >/dev/null

apt update

# Docker
echo "Installing Docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
	"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/${ID} "${VERSION_CODENAME}" stable" |
	tee /etc/apt/sources.list.d/docker.list >/dev/null

apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# VsCode
echo "Installing VsCode"
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft-archive-keyring.gpg
echo \
	"deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] \
  https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

apt update
apt install -y code

# PHP
case "$ID" in
"debian") curl -sSL https://packages.sury.org/php/README.txt | sudo bash -x ;;
"ubuntu") LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php ;;
esac
apt update

for ver in "8.0" "8.1" "8.2" "7.0" "7.4"; do
	echo "Installing php-${ver}"
	apt install php${ver}-amqp php${ver}-apcu php${ver}-bcmath php${ver}-bz2 php${ver}-cgi php${ver}-cli php${ver}-common php${ver}-curl php${ver}-decimal php${ver}-enchant php${ver}-excimer php${ver}-fpm php${ver}-gd php${ver}-gearman php${ver}-gmagick php${ver}-gmp php${ver}-gnupg php${ver}-grpc php${ver}-http php${ver}-imap php${ver}-inotify php${ver}-interbase php${ver}-intl php${ver}-libvirt-php php${ver}-lz4 php${ver}-mailparse php${ver}-maxminddb php${ver}-mbstring php${ver}-mcrypt php${ver}-memcache php${ver}-memcached php${ver}-mongodb php${ver}-msgpack php${ver}-mysql php${ver}-oauth php${ver}-odbc php${ver}-opcache php${ver}-pcov php${ver}-pgsql php${ver}-phpdbg php${ver}-pinba php${ver}-protobuf php${ver}-ps php${ver}-pspell php${ver}-psr php${ver}-raphf php${ver}-rdkafka php${ver}-readline php${ver}-redis php${ver}-rrd php${ver}-smbclient php${ver}-soap php${ver}-solr php${ver}-sqlite3 php${ver}-ssh2 php${ver}-stomp php${ver}-swoole php${ver}-sybase php${ver}-tideways php${ver}-tidy php${ver}-uopz php${ver}-uploadprogress php${ver}-uuid php${ver}-vips php${ver}-xdebug php${ver}-xhprof php${ver}-xml php${ver}-xmlrpc php${ver}-xsl php${ver}-yaml php${ver}-zip php${ver}-zmq php${ver}-zstd
done

# PhpStorm +(Toolbox)
curl -L https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.27.3.14493.tar.gz -o /tmp/toolbox.tar.gz
tar -xvf /tmp/toolbox.tar.gz jetbrains-toolbox -C /usr/local/bin/
