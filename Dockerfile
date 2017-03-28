FROM alpine:3.4
MAINTAINER Fredrik Lundhag <f@mekk.com>
ADD carbonapi /
USER nobody
EXPOSE 8080
CMD ["sh", "-c", "/carbonapi -config /carbonapi.yml"]
