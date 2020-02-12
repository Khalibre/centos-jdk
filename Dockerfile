FROM azul/zulu-openjdk-centos:11
LABEL maintainer="Sida Say <sida.say@khalibre.com>"

# Install necessary packages
RUN set -x \
    && yum install -y epel-release \
    && yum -y update \
    && yum -y install unzip ghostscript ImageMagick clamav telnet tree \
    && curl -L -o /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64 \
    && curl -L -o /usr/local/bin/gosu.asc https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64.asc \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && yum clean metadata \
    && yum clean all \
    && rm -rf /var/cache
