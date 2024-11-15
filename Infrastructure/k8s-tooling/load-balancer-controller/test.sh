#!/bin/bash

alb_check=$(kubectl get pods -n kube1-system |grep aws-load-balancer |grep -i running| wc -l)
if [ ! -n $alb_check ]; then
	echo "ok"
fi
