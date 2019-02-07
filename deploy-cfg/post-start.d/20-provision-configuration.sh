#!/bin/bash

source deploy-cfg/include/pre-script.sh

cd $OPENNMS_ROOT/etc

if [ "$OS" == "Darwin" ]; then
  export FUTURE="`date -v+1M "+%H:%M"`"
fi

if [ "$OS" == "Linux" ]; then
  export FUTURE="`date --date "1 minute" "+%H:%M"`"
fi

export HOUR="`echo $FUTURE | cut -f 1 -d: `"
export MINUTE="`echo $FUTURE | cut -f 2 -d: `"

cat $OPENNMS_ROOT/deploy-cfg/etc/provisiond-configuration.xml | sed "s/MM/$MINUTE/g" | sed "s/HH/$HOUR/g" > $OPENNMS_ROOT/etc/provisiond-configuration.xml

$OPENNMS_ROOT/bin/send-event.pl uei.opennms.org/internal/reloadDaemonConfig --parm 'daemonName Provisiond'

cd $OPENNMS_ROOT

source deploy-cfg/include/post-script.sh
