# SCM-Manager (scm-server)
#
FROM alpine:3.1
MAINTAINER Niko Mahle <niko.mahle@googlemail.com>
RUN apk add --update openjdk7-jre curl mercurial && rm -rf /var/cache/apk/*

# scm-server environment
ENV SCM_VERSION 1.45
ENV SCM_PKG_URL https://maven.scm-manager.org/nexus/content/repositories/releases/sonia/scm/scm-server/${SCM_VERSION}/scm-server-${SCM_VERSION}-app.tar.gz
ENV SCM_HOME /var/lib/scm

RUN /usr/sbin/addgroup scm && /usr/sbin/adduser -D -H -h /opt/scm -G scm -s /bin/sh scm \
 && mkdir -p /opt && curl -Lks "$SCM_PKG_URL" | tar -zxC /opt \
 && chown -R scm:scm /opt/scm-server \
 && mkdir -p /var/lib/scm \
 && chown -R scm:scm /var/lib/scm \
 && sed -i -e "s/^#!\/bin\/bash/#!\/bin\/sh/" /opt/scm-server/bin/scm-server \
 && chmod +x /opt/scm-server/bin/scm-server

WORKDIR /opt/scm-server/bin
VOLUME /var/lib/scm
EXPOSE 8080
USER scm
CMD ["/opt/scm-server/bin/scm-server"]
