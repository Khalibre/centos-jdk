FROM centos:7
LABEL maintainer="Sida Say <sida.say@khalibre.com>"

# Install necessary packages
RUN set -x \
    && rpm --import http://repos.azulsystems.com/RPM-GPG-KEY-azulsystems \
    && curl -o /etc/yum.repos.d/zulu.repo http://repos.azulsystems.com/rhel/zulu.repo \
    && yum install -y epel-release \
    && yum -y update \
    && yum -y install zulu-8-8.40.0.25-1 unzip ghostscript ImageMagick clamav telnet tree \
    && curl -L -o /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64 \
    && curl -L -o /usr/local/bin/gosu.asc https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64.asc \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && chmod +x /usr/local/bin/gosu \
    && rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && yum clean metadata \
    && yum clean all \
    && rm -rf /var/cache

# Set the JAVA_HOME variable to make it clear where Java is located
ENV JAVA_HOME /usr/lib/jvm/zulu-8
