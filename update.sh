m="$(git pull)"
ok="Already up to date."

if [ "$m" ==  "$ok" ]
then
    echo "Tariq already up to date :-)"
else
    echo "$m"
fi

