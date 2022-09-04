sudo apt update -y
aptvar=$(dpkg --get-selections apache2 |awk '{print $1}')
if [ "$aptvar"="apache2" ]
        then
                echo "apache is already installed"
else
        sudo apt-get update
        sudo apt install apache2
        echo "apache is installed"
fi
activeptr=$(sudo systemctl status apache2 | grep "active" | awk '{print $2}')
if [ "$activeptr"="active" ]
        then
                echo "apache is already active"
else
        sudo service apache2 start
        echo "apache is active"
fi
serviceptr=$(sudo systemctl is-enabled apache2 | awk '{print $1}')
if [ "$serviceptr"="enabled" ]
        then
                echo "apache service is already enabled"
else
        sudo systemctl enable apache2
        echo "service is enabled"
fi
name='Viraj'
timestamp=$(date '+%d%m%Y-%H%M%S')
cd /var/log/apache2/
tar -czvf /tmp/${name}-httpd-logs-${timestamp}.tar *.log

sudo apt update
sudo apt install awscli

s3bucket='upgrad-viraj'

aws s3 \
cp /tmp/${name}-httpd-logs-${timestamp}.tar \
s3://${s3bucket}/${name}-httpd-logs-${timestamp}.tar


size=$(ls -lh /tmp/${name}-httpd-logs-${timestamp}.tar |awk '{print $5}')
cd /var/www/html/
inventory_file='/var/www/html/inventory.html'
if [ -f "$inventory_file" ]
        then
                echo "file is already existed"
else
        echo "Log Type         Time Created         Type        Size" >> inventory.html
        echo -e "httpd-logs		${timestamp}		tar		${size}" >> inventory.html

fi

cd /etc/cron.d/
cron_file='/etc/cron.d/automation'
if [ -f "$cron_file" ]
        then
                echo "cron_file is already existed"
else
        echo "0 0 * * * root /root/Automation_Project/automation.sh" >> automation
       
fi

