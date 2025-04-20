FROM debian:stable-slim AS base

RUN apt-get update && apt-get install -y --no-install-recommends gmediarender \
    gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-plugins-bad && \
    apt-get autoremove -y && apt-get clean && apt-get autoclean && \
    rm -rf /var/lib/apt/lists/*

#FROM scratch
#COPY --from=base / /

ENV TZ=Asia/Shanghai

LABEL maintainer="Limory" \
      source="https://github.com/limory/hi3798mv100-server-tools"

ENTRYPOINT ["sh", "-c", "gmediarender -f DLNA-$HOSTNAME \"$@\"", "--"]

#build
#docker build -t dlna:v1 .
#usage
#docker run -itd -v /etc/asound.conf:/etc/asound.conf -h DLNA-i7 --name DLNA-i7 --restart unless-stopped --net host --device /dev/snd dlna:v1
