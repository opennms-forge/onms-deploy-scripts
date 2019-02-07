#!/bin/bash

source deploy-cfg/include/pre-script.sh

ln -s $SOURCE/bin $OPENNMS_ROOT/ >>$OPENNMS_ROOT/deploy.log 2>&1
ln -s $SOURCE/contrib $OPENNMS_ROOT/ >>$OPENNMS_ROOT/deploy.log 2>&1
ln -s $SOURCE/docs $OPENNMS_ROOT/ >>$OPENNMS_ROOT/deploy.log 2>&1
ln -s $SOURCE/jetty-webapps $OPENNMS_ROOT/ >>$OPENNMS_ROOT/deploy.log 2>&1
ln -s $SOURCE/lib $OPENNMS_ROOT/ >>$OPENNMS_ROOT/deploy.log 2>&1
ln -s $SOURCE/deploy $OPENNMS_ROOT/ >>$OPENNMS_ROOT/deploy.log 2>&1
ln -s $SOURCE/system $OPENNMS_ROOT/ >>$OPENNMS_ROOT/deploy.log 2>&1

source deploy-cfg/include/post-script.sh
