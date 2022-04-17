#!/bin/bash
beforeMD5="$(md5sum domains | sed 's/ //g')"
curl https://gist.githubusercontent.com/AliKhadivi/465b897173ebe1f2922a7adc85c5f214/raw > domains
afterMD5="$(md5sum domains | sed 's/ //g')"
if [ $beforeMD5 == $afterMD5 ]
then
        echo "Not changed Domains"
	# exit
fi



#./update_domains.sh
docker build -t alikhadivi/tariq .
tariq restart
#tariq stop
#tariq start
#sleep 14
#tariq status

