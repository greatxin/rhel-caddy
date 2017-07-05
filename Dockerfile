FROM registry.access.redhat.com/rhel7:latest
LABEL maintainer "Robert Baumgartner <robert.baumgartner@redhat.com>"

LABEL caddy_version="0.10.4" architecture="amd64"

ARG plugins=http.git

# RUN apk add --no-cache openssh-client git tar curl

RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/amd64?plugins=${plugins}" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy /srv \
 && /usr/bin/caddy -version

EXPOSE 2015
VOLUME /root/.caddy
WORKDIR /srv

COPY Caddyfile /etc/Caddyfile

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
