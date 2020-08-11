#!/bin/bash
typeset -l apnames
oid_ap=1.3.6.1.4.1.14179.2.2.1.1.3
oid_num=1.3.6.1.4.1.14179.2.2.2.1.15
oid_channel=1.3.6.1.4.1.14179.2.2.13.1.3
snmpdata="snmpwalk -v 2c -c hello IP_WLC"
prefix=office-ap-bj-
apnames=`$snmpdata $oid_ap |awk -F "\"" '{print $2}'`

for j in $apnames
do

        for i in `$snmpdata $oid_ap|grep -i $j | awk -F "=" '{print $1}'| awk -F "2.2.1.1.3." '{print $2}'`
        do
                count_radio0=`$snmpdata $oid_num.$i.0 | awk -F "Counter32:" '{print $2}'`
                count_radio1=`$snmpdata $oid_num.$i.1 | awk -F "Counter32:" '{print $2}'`
                utilization_radio0=`$snmpdata $oid_channel.$i.0|awk -F ":" '{print $4}'`
                utilization_radio1=`$snmpdata $oid_channel.$i.1|awk -F ":" '{print $4}'`
###--------Get Total Number Of Clients Per AP--------###
#               number=`expr $num1 +$num2`
###--------Get CISCO Clients Count Of AP Per Radio--------###
                echo $prefix$j  radio0 $count_radio0
                echo $prefix$j  radio1 $count_radio1 
###--------Get CISCO Channel Utilization Of AP Per Radios-----------###                
                echo $prefix$j  uti_channel_r0 $utilization_radio0
                echo $prefix$j  uti_channel_r1 $utilization_radio1
        done
done


