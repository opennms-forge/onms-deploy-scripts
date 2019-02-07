#!/bin/bash

source deploy-cfg/include/pre-script.sh

chown $DEV_USER:$DEV_GROUP $OPENNMS_ROOT/bin >>$OPENNMS_ROOT/deploy.log 2>&1
chown $DEV_USER:$DEV_GROUP $OPENNMS_ROOT/contrib >>$OPENNMS_ROOT/deploy.log 2>&1
chown $DEV_USER:$DEV_GROUP $OPENNMS_ROOT/docs >>$OPENNMS_ROOT/deploy.log 2>&1
chown $DEV_USER:$DEV_GROUP $OPENNMS_ROOT/jetty-webapps >>$OPENNMS_ROOT/deploy.log 2>&1
chown $DEV_USER:$DEV_GROUP $OPENNMS_ROOT/lib >>$OPENNMS_ROOT/deploy.log 2>&1
chown $DEV_USER:$DEV_GROUP $OPENNMS_ROOT/deploy >>$OPENNMS_ROOT/deploy.log 2>&1
chown $DEV_USER:$DEV_GROUP $OPENNMS_ROOT/system >>$OPENNMS_ROOT/deploy.log 2>&1

source deploy-cfg/include/post-script.sh
