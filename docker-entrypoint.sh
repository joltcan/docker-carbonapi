#!/bin/sh

exec /carbonapi -z=http://$CARBONZIPPER_HOST -stdout -logdir "" -mc $MEMCACHED_HOST -graphite $GRAPHITE_HOST
