#!/bin/bash

source deploy-cfg/include/pre-script.sh

cd $OPENNMS_ROOT/bin
./runjava -s >>$OPENNMS_ROOT/deploy.log 2>&1
cd $OPENNMS_ROOT

source deploy-cfg/include/post-script.sh
