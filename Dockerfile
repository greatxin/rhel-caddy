FROM registry.access.redhat.com/rhel7:latest
LABEL maintainer "Robert Baumgartner <robert.baumgartner@redhat.com>"

LABEL caddy_version="0.10.4" architecture="amd64"

ENV CADDY_FILE=none

ARG plugins=http.git

# RUN apk add --no-cache openssh-client git tar curl

COPY Caddyfile /etc/Caddyfile

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh 

RUN  /entrypoint.sh

RUN curl --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/amd64?plugins=${plugins}&license=personal" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \
 && chmod 0777 /srv \
 && /usr/bin/caddy -version

EXPOSE 2015
VOLUME /root/.caddy
WORKDIR /srv

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
