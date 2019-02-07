#!/bin/bash

source deploy-cfg/include/pre-script.sh

sudo -u "${SUDO_USER}" ssh-keygen -R '[localhost]:8101' >>$OPENNMS_ROOT/deploy.log 2>&1

source deploy-cfg/include/post-script.sh
