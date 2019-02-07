#!/bin/bash

export SIMULATION="false"
export REDEPLOY="false"
export OS="`uname`"

if [ "$OS" == "Linux" ]; then
  export DEV_ROOT="/home/chris/dev/opennms"
  export DEV_USER="chris"
  export DEV_GROUP="chris"
  export OPENNMS_ROOT="/opt/opennms"
  export POSTGRES_BINARIES="/usr/bin"
fi

if [ "$OS" == "Darwin" ]; then
  export DEV_ROOT="/Volumes/Daten/OpenNMS/dev/opennms"
  export DEV_USER="chris"
  export DEV_GROUP="staff"
  export OPENNMS_ROOT="/opt/opennms"
  export POSTGRES_BINARIES="/Library/PostgreSQL/9.6/bin"
fi

IFS=$'\n' options=( `find $DEV_ROOT/*/target -mindepth 1 -maxdepth 1 -type d -name "opennms-*-SNAPSHOT"` )
PS3=">"

if [ "$(id -u)" != "0" ]; then
  echo "-> ERROR: This script must be run as root" 1>&2
  exit 1
fi

function usage () {
  echo "-> USAGE: deploy.sh deploy|redeploy|rerun|start|debug|status|stop|restart|simulate|clean|cleandb"
  echo "->        phase 'deploy' runs choose, info, stop, clean, deploy, pre-start, start, post-start"
  echo "->        phase 'redeploy' runs choose, info, stop, clean, redeploy, pre-start, start, post-start"
  echo "->        phase 'rerun' runs post-start"
  echo "->        phase 'start' runs start, post-start"
  echo "->        phase 'debug' runs debug, post-start"
  echo "->        phase 'status: status"
  echo "->        phase 'stop' runs stop"
  echo "->        phase 'restart: restart, post-start"
  echo "->        phase 'simulate' runs simulate, choose, info, stop, clean, deploy, pre-start, start, post-start"
  echo "->        phase 'clean' runs stop, clean"
  echo "->        phase 'cleandb' runs stop, cleandb"
}

function choose () {
  echo "*************************"
  echo "* OpenNMS DEPLOY SCRIPT *"
  echo "*************************"
  echo "-> INFO: Operating system: $OS"
  echo "-> INFO: Development root directory: $DEV_ROOT"
  echo "-> INFO: OpenNMS installation directory: $OPENNMS_ROOT"
  echo "-> INFO: Please select build to deploy:"
  echo ""

  select opt in "${options[@]}" "Quit"; do
    case "$REPLY" in

    $(( ${#options[@]}+1 )) ) echo "INFO: Goodbye!"
                              exit;;

    *) if [[ "$REPLY" != [0-9]* ]]; then
         echo "-> WARNING: invalid option. Try another one."
         continue
       fi
       if [ "$REPLY" -ge "1" ]; then
         if [ "$REPLY" -le "${#options[@]}" ]; then
           export SOURCE="${options[$REPLY-1]}"
           break
         else
           echo "-> WARNING: invalid option. Try another one."
           continue
         fi
       else
         echo "-> WARNING: invalid option. Try another one."
         continue
       fi
    esac
  done
  echo ""
}

function start () {
  if [ "$SIMULATION" == "true" ]; then
    echo "-> START: Starting OpenNMS: skipped"
    return 0
  fi
  echo -n "-> START: Starting OpenNMS... "
  if [ -f $OPENNMS_ROOT/bin/opennms ]; then
    $OPENNMS_ROOT/bin/opennms start >>$OPENNMS_ROOT/deploy.log 2>&1
    if [ "$?" == "0" ]; then
      echo "ok"
    else
      echo "fail"
    fi
  else
    echo "-> ERROR: file 'bin/opennms' not found!"
    exit 1
  fi
}

function debug () {
  echo -n "-> DEBUG: Debugging OpenNMS... "
  if [ -f $OPENNMS_ROOT/bin/opennms ]; then
    $OPENNMS_ROOT/bin/opennms -t start  >>$OPENNMS_ROOT/deploy.log 2>&1
    if [ "$?" == "0" ]; then
      echo "ok"
    else
      echo "fail"
    fi
  else
    echo "-> ERROR: file 'bin/opennms' not found!"
    exit 1
  fi
}

function status () {
  echo "-> STATUS: Checking OpenNMS status... "
  if [ -f $OPENNMS_ROOT/bin/opennms ]; then
    $OPENNMS_ROOT/bin/opennms -v status
  else
    echo "-> ERROR: file 'bin/opennms' not found!"
    exit 1
  fi
}

function stop () {
  if [ "$SIMULATION" == "true" ]; then
    echo "-> STOP: Stopping OpenNMS: skipped"
    return 0
  fi
  echo -n "-> STOP: Stopping OpenNMS... "
  if [ -f $OPENNMS_ROOT/bin/opennms ]; then
    $OPENNMS_ROOT/bin/opennms stop >>$OPENNMS_ROOT/deploy.log 2>&1
    if [ "$?" == "0" ]; then
      echo "ok"
    else
      echo "fail"
    fi
  else
    echo "-> WARNING: file 'bin/opennms' not found!"
  fi
}

function restart () {
  echo -n "-> RESTART: Restarting OpenNMS... "
  if [ -f $OPENNMS_ROOT/bin/opennms ]; then
    $OPENNMS_ROOT/bin/opennms restart  >>$OPENNMS_ROOT/deploy.log 2>&1
    if [ "$?" == "0" ]; then
      echo "ok"
    else
      echo "fail"
    fi
  else
    echo "-> ERROR: file 'bin/opennms' not found!"
    exit 1
  fi
}

function cleandb () {
  ./deploy-cfg/include/cleandb.sh
}

function pre-start () {
  for script in $OPENNMS_ROOT/deploy-cfg/pre-start.d/*; do
    if [ -f $script -a -x $script ]; then
      echo -n "-> PRE-START: executing '$script'... "
      $script >>$OPENNMS_ROOT/deploy.log 2>&1
      if [ "$?" == "0" ]; then
        echo "ok"
      else
        echo "fail"
      fi
    fi
  done
}

function clean () {
  for script in $OPENNMS_ROOT/deploy-cfg/clean.d/*; do
    if [ -f $script -a -x $script ]; then
      echo -n "-> CLEAN: executing '$script'... "
      $script >>$OPENNMS_ROOT/deploy.log 2>&1
      if [ "$?" == "0" ]; then
        echo "ok"
      else
        echo "fail"
      fi
    fi
  done
}

function post-start () {
  for script in $OPENNMS_ROOT/deploy-cfg/post-start.d/*; do
    if [ -f $script -a -x $script ]; then
      echo -n "-> POST-START: executing '$script'... "
      $script >>$OPENNMS_ROOT/deploy.log 2>&1
      if [ "$?" == "0" ]; then
        echo "ok"
      else
        echo "fail"
      fi
    fi
  done
}

function  deploy () {
  for script in $OPENNMS_ROOT/deploy-cfg/deploy.d/*; do
    if [ -f $script -a -x $script ]; then
      echo -n "-> DEPLOY: executing '$script'... "
      $script >>$OPENNMS_ROOT/deploy.log 2>&1
      if [ "$?" == "0" ]; then
        echo "ok"
      else
        echo "fail"
      fi
    fi
  done
}

function remove_deploy_log () {
  rm /opt/opennms/deploy.log &> /dev/null
}

function info () {
  echo "-> INFO: using build directory $SOURCE"
}

function simulate () {
  echo "-> INFO: using simulation mode"
  export SIMULATION="true"
}

remove_deploy_log

case $1 in
  deploy)
    choose
    info
    stop
    clean
    deploy
    pre-start
    start
    post-start

    exit 0;
    ;;
  simulate)
    simulate
    choose
    info
    stop
    clean
    deploy
    pre-start
    start
    post-start

    exit 0;
    ;;
  clean)
    stop
    clean

    exit 0;
    ;;
  redeploy)
    export REDEPLOY="true"

    choose
    info
    stop
    clean
    deploy
    pre-start
    start
    post-start

    exit 0;
    ;;
  rerun)
    post-start

    exit 0;
    ;;
  debug)
    debug
    post-start

    exit 0;
    ;;
  start)
    start
    post-start

    exit 0;
    ;;
  status)
    status

    exit 0;
    ;;
  stop)
    stop

    exit 0;
    ;;
  restart)
    restart
    post-start

    exit 0;
    ;;
  cleandb)
    stop
    cleandb

    exit 0;
    ;;
  *)
    usage

    exit 2;
    ;;
esac
