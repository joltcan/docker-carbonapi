# carbonapi

The [carbonapi](https://github.com/dgryski/carbonapi), dockerized by [me](https://github.com/joltcan).

## Why diz?

I only need the binary, not all a proper dist, so I :
* Compile go-carbon with golang docker
* Copy the static binary to a [alpine](https://hub.docker.com/_/alpine/) container. Could't just use the binary because you have to pass ENV variables on which carbonzipper to connect to and for that I needed a shell.

## How do I get it rolling?

* docker pull jolt/carbonapi
* get the example conf and modify it to your liking

In short:
```shell
docker run -d --name carbonapi -v carbonapi.conf:/carbonapi.conf -p 8186:8186 jolt/carbonapi
```

### Thanks to
[bodsch](https://github.com/bodsch/docker-go-carbon), who created the Dockerfile/Makefile that I started out with.
