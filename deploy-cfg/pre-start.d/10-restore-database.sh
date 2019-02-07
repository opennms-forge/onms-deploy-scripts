#!/bin/bash

source deploy-cfg/include/pre-script.sh

if [ "$REDEPLOY" == "false" ]; then
  if [ -s deploy-cfg/db/opennms.pgsql.gz ]; then
    PGHOST=/tmp $POSTGRES_BINARIES/createdb --user postgres -O opennms opennms >>$OPENNMS_ROOT/deploy.log 2>&1
    PGHOST=/tmp $POSTGRES_BINARIES/pg_restore -U opennms -Fc -d opennms -U postgres deploy-cfg/db/opennms.pgsql.gz >>$OPENNMS_ROOT/deploy.log 2>&1
  else
    exit 1
  fi
fi

source deploy-cfg/include/post-script.sh
