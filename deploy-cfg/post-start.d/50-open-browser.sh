#!/bin/bash

source deploy-cfg/include/pre-script.sh

if [ "$OS" == "Darwin" ]; then
  open http://localhost:8980/opennms/
fi

source deploy-cfg/include/post-script.sh
