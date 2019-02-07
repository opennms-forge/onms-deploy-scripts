#!/bin/bash

source deploy-cfg/include/pre-script.sh

if [ "$REDEPLOY" == "false" ]; then
  PGHOST=/tmp $POSTGRES_BINARIES/psql --host localhost --user postgres -c "DROP DATABASE opennms" >>$OPENNMS_ROOT/deploy.log 2>&1
fi

source deploy-cfg/include/post-script.sh
