#!/bin/bash
if [ "$encrypt" = true ] ; then
    # Launch nginx
    echo "Starting nginx..."
    nginx -g 'daemon off;'
fi
