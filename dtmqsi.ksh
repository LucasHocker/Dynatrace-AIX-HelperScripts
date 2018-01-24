#!/bin/ksh
###############
# dtmqsi - add OneAgent to all MQSI Integration server JVMs
#          Note: currently only provides, system and JVM metrics, no PurePaths / E2E queue-tracing
##############

## Config section, get info from manifest.jso
DEBUG=true
file=/opt/dynatrace/oneagent/agent/bin/aix-ppc-64/liboneagentloader.so
tenant=XXXXXXXX
token=XXXXXXXXXXXXXXXX
endpoint=https://XXXXXXXXXXXXXXXXXXXXX.com:9999/communication


## Get nodes
for node in $(mqsilist -d0 | grep BIP8099I | awk '{print $4}'); do

   ## Get Servers
   for server in $(mqsilist -d0 $node | grep BIP8130I | awk '{print $4}'); do

      ## Instrument each
	if [[ $DEBUG="true" ]];then
	   echo mqsichangeproperties -f $node -o ComIbmJVMManager -e $server -n jvmSystemProperty -v\"-agentpath:$file=tenant=$tenant,tenantToken=$token,server=$endpoint\"
	else
	   mqsichangeproperties -f $node -o ComIbmJVMManager -e $server -n jvmSystemProperty -v\"-agentpath:$file=tenant=$tenant,tenantToken=$token,server=$endpoint\"
	fi
   done

   ## Restart the nodes for you
   if [[ $DEBUG="true" ]];then
      echo "mqsistop $node; mqsistart $node"
   else
      mqsistop $node; mqsistart $node
   fi
done
