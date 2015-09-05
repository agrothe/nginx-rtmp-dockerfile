NGINX RTMP Dockerfile
=====================

FORK from `https://github.com/brocaar/nginx-rtmp-dockerfile`

Changes:
Mounts a volume to access the config file, so changes can be made without rebuilding the image and mounts log files in the host operating system. Also, made some build changes to reflect building on Debian Jessie with latest stable versions of Nginx and Nginx-rtmp module.

This Dockerfile installs NGINX configured with `nginx-rtmp-module`, ffmpeg
and some default settings for HLS live streaming.

**Note: in the current state, this is just an experimental project to play with
RTMP and HLS.**


How to user
-----------

1. Build and run the container (`docker build -t nginx_rtmp .` &
   `docker run -p 1935:1935 -p 8080:80  -v /logs/:/logs/ -v /config/:/config/ --rm nginx_rtmp`).

2. Stream your live content to `rtmp://localhost:1935/encoder/stream_name` where
   `stream_name` is the name of your stream.

3. In Safari, VLC or any HLS compatible browser / player, open
   `http://localhost:8080/hls/stream_name.m3u8`. Note that the first time,
   it might take a few (10-15) seconds before the stream works. This is because
   when you start streaming to the server, it needs to generate the first
   segments and the related playlists.


Links
-----

* http://nginx.org/
* https://github.com/arut/nginx-rtmp-module
* https://www.ffmpeg.org/
* https://obsproject.com/
