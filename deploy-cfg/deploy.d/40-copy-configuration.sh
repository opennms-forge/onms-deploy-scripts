#!/bin/bash

source deploy-cfg/include/pre-script.sh

cp -pR $OPENNMS_ROOT/deploy-cfg/etc/* $OPENNMS_ROOT/etc/ >>$OPENNMS_ROOT/deploy.log 2>&1

source deploy-cfg/include/post-script.sh
