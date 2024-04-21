#!/bin/bash
RED='\033[0;31m'
NOCOLOR='\033[0m'

NS="sre"

D_E="swype-app"

MAX_RESTART=3

while true; 
do
RESTARTS=$(kubectl get pods -n ${NS} -l app=${D_E} -o jsonpath="{.items[0].status.containerStatuses[0].restartCount}")
echo "Number of restarts: ${RESTARTS}"
if (( RESTARTS > MAX_RESTART )); 
then
echo "Maximum number of restarts exceeded. RED button executed..."
kubectl scale --replicas=0 deployment/${D_E} -n ${NS}
break
fi

sleep 60

done


