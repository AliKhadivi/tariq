#!/bin/bash

beforeMD5="$(md5sum domains | sed 's/ //g')"
#curl https://raw.githubusercontent.com/ab77/netflix-proxy/master/data/conf/zones.override.template | \
curl https://gist.githubusercontent.com/AliKhadivi/465b897173ebe1f2922a7adc85c5f214/raw/c67c5e5ae6517fd27f45e5e8d5a319c841650baa/beshcan-domains.txt > domains
#curl https://gist.githubusercontent.com/AliKhadivi/465b897173ebe1f2922a7adc85c5f214/raw/c67c5e5ae6517fd27f45e5e8d5a319c841650baa/beshcan-domains.txt | \
#    awk '/^zone\s/ { if (match($2, /^"(.+)\."$/, m) != 0) print m[1]; }' > domains


afterMD5="$(md5sum domains | sed 's/ //g')"

#echo "$beforeMD5 \n\n $afterMD5"

if [ $beforeMD5 == $afterMD5 ]
then
	echo "Not changed Domains"
	exit
fi

docker build -t alikhadivi/tariq .
tariq restart

# to check your speed run: wget https://cachefly.cachefly.net/100mb.test
#echo cachefly.net >> domains

