#!/bin/bash

# Reduce maximum number of number of open file descriptors to 1024
# otherwise slapd consumes two orders of magnitude more of RAM
# see https://github.com/docker/docker/issues/8231
ulimit -n 1024

/usr/local/openldap/sbin/slapd-source-cli start && \
  /usr/local/openldap/sbin/slapd-dest-cli start && \
  tail -f /dev/null
