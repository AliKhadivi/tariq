if ! command -v tariq &>/dev/null; then
    echo "tariq not installed!"
    exit 1
fi

#write out current crontab
sudo crontab -l >/tmp/tariq_cron
#echo new cron into cron file
# echo "0 */1 * * * echo hello" >> /tmp/tariq_cron
crontab="*/15 * * * * tariq reload-ddns"

if grep -Fxq "$crontab" /tmp/tariq_cron; then
    echo "Crontab already exist."
else
    sudo echo "$crontab" >>/tmp/tariq_cron
    sudo crontab /tmp/tariq_cron
fi

sudo rm /tmp/tariq_cron
