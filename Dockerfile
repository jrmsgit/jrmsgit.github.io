FROM debian:forky-20250908-slim

LABEL maintainer="Jeremías Casteglione <jrmsdev@gmail.com>"
LABEL version="250707"

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

ENV DEBIAN_FRONTEND noninteractive

ENV APT_INSTALL bash openssl ca-certificates media-types less wget npm

RUN apt-get clean \
	&& apt-get update -yy \
	&& apt-get dist-upgrade -yy --purge \
	&& apt-get install -yy --no-install-recommends ${APT_INSTALL} \
	&& apt-get clean \
	&& apt-get autoremove -yy --purge \
	&& rm -rf /var/lib/apt/lists/* \
		/var/cache/apt/archives/*.deb \
		/var/cache/apt/*cache.bin

ENV APT_INSTALL_EXTRA make shellcheck

RUN apt-get clean \
	&& apt-get update -yy \
	&& apt-get install -yy --no-install-recommends ${APT_INSTALL_EXTRA} \
	&& apt-get clean \
	&& apt-get autoremove -yy --purge \
	&& rm -rf /var/lib/apt/lists/* \
		/var/cache/apt/archives/*.deb \
		/var/cache/apt/*cache.bin

COPY ./hugo/install.sh /tmp/hugo-install.sh
RUN /bin/sh /tmp/hugo-install.sh && rm -f /tmp/hugo-install.sh

ARG DEVEL_UID=1000
ARG DEVEL_GID=1000

ENV DEVEL_UID ${DEVEL_UID}
ENV DEVEL_GID ${DEVEL_GID}

RUN groupadd -o -g ${DEVEL_GID} devel \
	&& useradd -o -d /home/devel -m -c 'devel' -g ${DEVEL_GID} -u ${DEVEL_UID} devel \
	&& chmod -v 0750 /home/devel

RUN printf 'umask %s\n' '027' >>/home/devel/.profile
RUN printf "export PS1='%s '\n" '\u@\h:\W\$' >>/home/devel/.profile

COPY ./docker/user-login.sh /usr/local/bin/user-login.sh
RUN chmod -v 0755 /usr/local/bin/user-login.sh

RUN install -v -m 0750 -o devel -g devel -d /opt/jrmsgit
RUN install -v -m 0750 -o devel -g devel -d /opt/jrmsgit/site

USER devel:devel
WORKDIR /home/devel

ENV USER devel
ENV HOME /home/devel

RUN npm version
RUN npx --version
RUN hugo version

ENV HUGO_BASEURL http://localhost:8045
ENV HUGO_ENVIRONMENT development

ENTRYPOINT /usr/local/bin/user-login.sh
