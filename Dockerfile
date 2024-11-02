FROM ghcr.io/linuxserver/baseimage-alpine:3.20

RUN apk add pipx vim curl
ENV PATH="$PATH:/root/.local/bin"
RUN pipx install organize-tool

RUN mkdir -p /organizetool

COPY runner.sh /organizetool/runner.sh

CMD ["/organizetool/runner.sh"]
