FROM debian:stable-slim AS base

RUN apt-get update && apt-get install -y --no-install-recommends build-essential autoconf automake libtool pkg-config \
                       libupnp-dev libgstreamer1.0-dev \
                       gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
                       gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
                       gstreamer1.0-libav gstreamer1.0-alsa \
                       git && \
    git -c http.sslVerify=false clone https://github.com/hzeller/gmrender-resurrect.git /gmr && \
    cd /gmr && ./autogen.sh && ./configure && make && make install && \
    apt-get remove -y build-essential autoconf automake libtool pkg-config git && \
    apt-get autoremove -y && apt-get clean && apt-get autoclean && \
    rm -rf /gmr /var/lib/apt/lists/*

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
