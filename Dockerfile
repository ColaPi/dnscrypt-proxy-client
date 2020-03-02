FROM alpine

LABEL MAINTAINER = colachg <colachg@gmail.com>

ENV VERSION=2.0.39
ENV LOCAL_PORT=53
ENV URL=https://github.com/jedisct1/dnscrypt-proxy/releases/download/$VERSION/dnscrypt-proxy-linux_x86_64-$VERSION.tar.gz

RUN set -ex &&\
    apk add --update --no-cache --virtual .build curl &&\
    curl -sSL $URL | tar xz --strip-components=1  -C /usr/local/bin/ linux-x86_64/dnscrypt-proxy &&\
    apk del --purge .build

WORKDIR /dnscrypt

EXPOSE $LOCAL_PORT/tcp $LOCAL_PORT/udp

ENTRYPOINT ["/usr/local/bin/dnscrypt-proxy"]

CMD ["-config", "dnscrypt-proxy.toml"]
