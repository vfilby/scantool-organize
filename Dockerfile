FROM python:3-slim-buster

RUN pip3 install organize-tool
RUN apt-get update && apt-get install -y --no-install-recommends \
  vim \
  curl

RUN mkdir -p /organizetool

COPY runner.sh /organizetool/runner.sh

CMD ["/organizetool/runner.sh"]
