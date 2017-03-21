# carbonapi

The [carbonapi](https://github.com/dgryski/carbonapi), dockerized by me.

## Why diz?

I only need the binary, not all a full UI, so I :
* Compile go-carbon with golang docker
* Copy the static binary to a [alpine](https://hub.docker.com/_/alpine/) container. Could't just use the binary because you have to pass ENV variables on which carbonzipper to connect to (and ENV parsing is messed up in docker).

## How do I get it rolling?

* docker pull jolt/carbonapi
* set the CARBONZIPPER_HOST (and port).
* set the GRAPHITE_HOST (and port) to send carbonapi-metrics to.
* (optionally) set MEMCACHED:HOST (and port).
* In short ```docker run -d --name carbonapi --env=CARBONZIPPER_HOST=10.0.3.1:8086,GRAPHITE_HOST=10.0.3.1:2003 jolt/carbonapi ```

### Thanks to
[bodsch](https://github.com/bodsch/docker-go-carbon), who created the Dockerfile/Makefile that I started out with.