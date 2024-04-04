FROM debian:10

ARG DNSMASQ_VERSION="2.85"
ENV DNSMASQ_VERSION=${DNSMASQ_VERSION}

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        rsyslog \
        openssh-server \
        tcpdump \
        net-tools \
        dnsmasq \
        iputils-ping \
        gosu \
    && rm -rf \
        /tmp/* \
        /var/tmp/* \
        /var/lib/apt/lists/*

RUN chmod 777 -R /var/lib/misc/
RUN < /dev/zero ssh-keygen -q -N ""
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

WORKDIR /
COPY docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh

# HEALTHCHECK CMD dig cloudflare.com A +dnssec +multiline @127.0.0.1 || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["dnsmasq", "-k"]