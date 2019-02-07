#!/bin/bash

if ! command -v $POSTGRES_BINARIES/psql >/dev/null 2>&1 ; then
  echo "-> ERROR: PostgreSQL 'psql' binary not found"
  exit 1;
fi

export "PGPASSWORD=secret"

function ask_yes_or_no() {
    read -p "$1 ([y]es or [N]o): "
    case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
        y|yes) echo "yes" ;;
        *)     echo "no" ;;
    esac
}

echo -n "-> INFO: Gathering OpenNMS test database(s)... "
$POSTGRES_BINARIES/psql -t -d postgres -U postgres -c "select 'drop database '||datname||';' from pg_database where datname like 'opennms_test_%'" > /var/tmp/delete.sql 2>/dev/null
if [ $? -ne 0 ]; then
    echo "fail"
    exit 1;
fi
echo "ok"

if [ "`cat /var/tmp/delete.sql | wc -l`" -ne "1" ]; then
  read -p "-> WARNING: Press [ENTER] to review the file '/var/tmp/delete.sql'"
  less /var/tmp/delete.sql
  if [ "yes" == $(ask_yes_or_no "-> WARNING: Are you sure?") ]; then
    echo -n "-> INFO: Dropping OpenNMS test database(s)... "
    $POSTGRES_BINARIES/psql -U postgres -f /var/tmp/delete.sql &> /dev/null
    if [ $? -ne 0 ]; then
        echo "fail"
        exit 1;
    fi
    echo "ok"
  fi
else
  echo "-> INFO: no OpenNMS test database(s) found"
fi
