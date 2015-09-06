# SCM-Manager (scm-server)
#
FROM nikom/alpine-java-base
MAINTAINER Niko Mahle <niko.mahle@googlemail.com>
RUN apk add --update openjdk7-jre curl mercurial && rm -rf /var/cache/apk/*

# scm-server environment
ENV SCM_VERSION 1.46
ENV SCM_PKG_URL https://maven.scm-manager.org/nexus/content/repositories/releases/sonia/scm/scm-server/${SCM_VERSION}/scm-server-${SCM_VERSION}-app.tar.gz
ENV SCM_HOME /var/lib/scm

RUN mkdir -p /opt && curl -Lks "$SCM_PKG_URL" | tar -zxC /opt \
 && mkdir -p /var/lib/scm \
 && sed -i -e "s/^#!\/bin\/bash/#!\/bin\/sh/" /opt/scm-server/bin/scm-server \
 && chmod +x /opt/scm-server/bin/scm-server

WORKDIR /opt/scm-server/bin
VOLUME /var/lib/scm
EXPOSE 8080
CMD ["/opt/scm-server/bin/scm-server"]
