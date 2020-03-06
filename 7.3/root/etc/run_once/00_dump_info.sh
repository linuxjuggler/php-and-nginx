#!/bin/sh

# popolate /web if empty

if [ ! -d /web/html ]; then
  mkdir -p /web/html
fi