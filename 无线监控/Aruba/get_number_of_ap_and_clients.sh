#!/bin/bash
#-----Get Number Of Clients--------# 
sum=0
host=office-aruba-bj-t2-11-ac-10
for i in `snmpwalk -v 2c -c momo 172.16.202.10 1.3.6.1.4.1.14823.2.2.1.5.2.1.7.1.12 | awk -F ":" '{print $4}'`
do
       sum=$((sum+$i))
done
zabbix_sender -z 127.0.0.1 -s $host -k clients -o  $sum

#-----Get Number Of AP-------#

ap_number=`snmpwalk -v 2c -c momo 172.16.202.10 1.3.6.1.4.1.14823.2.2.1.5.2.1.4.1.3 | wc -l`
zabbix_sender -z 127.0.0.1 -s $host -k ap_number -o  $ap_number

