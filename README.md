# armv7-dlna
gmrender-resurrect (gmediarender) 构建 armv7 平台 dlna 的 docker 镜像  
#build  
#docker build -t dlna:v1 .  
#usage  
#docker run -itd -v /etc/asound.conf:/etc/asound.conf -h DLNA-i7 --name DLNA-i7 --restart unless-stopped --net host --device /dev/snd dlna:v1
