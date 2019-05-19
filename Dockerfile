FROM scratch
LABEL maintainer="Fredrik Lundhag <f@mekk.com>"
ADD files/passwd.minimal /etc/passwd
ADD files/ /etc/carbonapi/
USER carbon
EXPOSE 8081
ADD carbonapi /
ENTRYPOINT ["./carbonapi", "-config", "/etc/carbonapi/carbonapi.yaml"]
