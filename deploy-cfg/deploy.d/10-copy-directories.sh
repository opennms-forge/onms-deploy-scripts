#!/bin/bash

source deploy-cfg/include/pre-script.sh

cp -pR $SOURCE/etc $OPENNMS_ROOT/ >>$OPENNMS_ROOT/deploy.log 2>&1
cp -pR $SOURCE/data $OPENNMS_ROOT/ >>$OPENNMS_ROOT/deploy.log 2>&1
cp -pR $SOURCE/share $OPENNMS_ROOT/ >>$OPENNMS_ROOT/deploy.log 2>&1
cp -pR $SOURCE/logs $OPENNMS_ROOT/ >>$OPENNMS_ROOT/deploy.log 2>&1

source deploy-cfg/include/post-script.sh
