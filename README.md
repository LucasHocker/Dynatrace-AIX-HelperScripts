# Dynatrace-AIX-HelperScripts
Small scripts to help instrument AIX processes


## dtmqsi.ksh 
Description: add OneAgent to all MQSI IntegrationServers JVMs
### Usage:
- Download OneAgent for AIX from your tenant
- Edit script with info from OneAgent's manifest.json
- Run ./dtmqsi.ksh, this will perform a dry-run
- Change DEBUG=true to DEBUG=false
- Run ./dtmqsi.ksh again to make the changes and restart your IntegrationNodes

### Notes:
- This currently only provides System & JVM metrics, no PurePaths or queue tracing
- This script will no longer be needed once full OneAgent is released for AIX
- Script assumes you want all nodes instrumented and restarted, edit or copy-paste only the desired dry-run output if some nodes should be left stopped
