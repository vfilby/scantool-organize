FROM ghcr.io/linuxserver/baseimage-alpine:3.20

RUN apk add py3-pip vim curl

# copy local files
COPY root/ /

RUN python3 -m venv /app
RUN . /app/bin/activate
ENV VIRTUAL_ENV /app
ENV PATH /app/bin:$PATH  

RUN /app/bin/pip3 install organize-tool
#RUN pip3 install organize-tool --break-system-packages
