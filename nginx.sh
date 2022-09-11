#!/bin/sh
if [ "$encrypt" = true ] ; then
    # Launch nginx
    echo "Starting nginx..."
    exec nginx -g 'daemon off;'
fi
