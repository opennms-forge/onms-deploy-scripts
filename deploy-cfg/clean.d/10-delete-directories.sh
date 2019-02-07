#!/bin/bash

source deploy-cfg/include/pre-script.sh

rm $OPENNMS_ROOT/bin >>$OPENNMS_ROOT/deploy.log 2>&1
rm $OPENNMS_ROOT/contrib >>$OPENNMS_ROOT/deploy.log 2>&1
rm $OPENNMS_ROOT/docs >>$OPENNMS_ROOT/deploy.log 2>&1
rm $OPENNMS_ROOT/jetty-webapps >>$OPENNMS_ROOT/deploy.log 2>&1
rm $OPENNMS_ROOT/lib >>$OPENNMS_ROOT/deploy.log 2>&1
rm $OPENNMS_ROOT/system >>$OPENNMS_ROOT/deploy.log 2>&1
rm $OPENNMS_ROOT/deploy >>$OPENNMS_ROOT/deploy.log 2>&1
rm -rf $OPENNMS_ROOT/etc >>$OPENNMS_ROOT/deploy.log 2>&1
rm -rf $OPENNMS_ROOT/data >>$OPENNMS_ROOT/deploy.log 2>&1
rm -rf $OPENNMS_ROOT/share >>$OPENNMS_ROOT/deploy.log 2>&1
rm -rf $OPENNMS_ROOT/logs >>$OPENNMS_ROOT/deploy.log 2>&1
rm -rf $OPENNMS_ROOT/instances >>$OPENNMS_ROOT/deploy.log 2>&1

source deploy-cfg/include/post-script.sh
