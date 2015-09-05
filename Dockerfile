FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive
ENV PATH=$PATH:/usr/local/nginx/sbin

EXPOSE 1935
EXPOSE 80

# create directories
RUN mkdir /src && mkdir /config && mkdir /logs && mkdir /data && mkdir /static

# update and upgrade packages
RUN apt-get apt-get  clean && update && apt-get upgrade -y
RUN apt-get install -y --fix-missing apt-utils build-essential wget

# ffmpeg
RUN echo "deb http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y --fix-missing --force-yes ffmpeg

# nginx dependencies
RUN apt-get install -y libpcre3-dev zlib1g-dev libssl-dev

# get nginx source
RUN cd /src && wget http://nginx.org/download/nginx-1.9.4.tar.gz && tar zxf nginx-1.9.4.tar.gz && rm nginx-1.9.4.tar.gz

# get nginx-rtmp module
RUN cd /src && wget https://github.com/arut/nginx-rtmp-module/archive/v1.1.7.tar.gz && tar zxf v1.1.7.tar.gz && rm v1.1.7.tar.gz

# compile nginx
RUN cd /src/nginx-1.9.4 && ./configure --add-module=/src/nginx-rtmp-module-1.1.7 --conf-path=/config/nginx.conf --error-log-path=/logs/error.log --http-log-path=/logs/access.log
RUN cd /src/nginx-1.9.4 && make && make install

# ADD nginx.conf /config/nginx.conf - removed as we now mount this from host volume
ADD static /static

CMD "nginx"
