FROM python:3-slim-buster

RUN pip3 install organize-tool
RUN apt-get update && apt-get install -y --no-install-recommends \
  vim \
  curl

# copy local files
COPY root/ /

# setup home and permissions appropriately for python
#
# We don't know what the UID is going to be so we can not set permissions up
# in advance and organize doesn't seem to respect XDG_DATA_HOME.  Nothing
# else should be using home, and organize only stores logs so this should
# be relatively safe
ENV HOME=/tmp

CMD ["/app/runner.sh"]
