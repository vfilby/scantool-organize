FROM python:3-slim-buster

RUN pip3 install organize-tool
RUN apt-get update && apt-get install -y --no-install-recommends \
  vim \
  curl
# copy local files
COPY root/ /

CMD ["/app/runner.sh"]
