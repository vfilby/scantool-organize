FROM python:3-slim-buster

ARG UID
ARG GID

RUN pip3 install organize-tool
RUN apt-get update && apt-get install -y --no-install-recommends \
  vim \
  curl

# copy local files
COPY root/ /

ENV HOME=/tmp
CMD ["/app/runner.sh"]
