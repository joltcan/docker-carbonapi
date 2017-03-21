FROM alpine:3.4
MAINTAINER Fredrik Lundhag <f@mekk.com>
ADD carbonapi /
ADD docker-entrypoint.sh /
ENV CARBONZIPPER_HOST 127.0.0.1:8086
ENV GRAPHITE_HOST 127.0.0.1:2003
ENV MEMCACHED_HOST ""
USER nobody
ENTRYPOINT ["/docker-entrypoint.sh"]
