#!/bin/bash
# run this in your project root folder

if [ -z "$BRAINCLOUD_TOOLS" ];
then
  export BRAINCLOUD_TOOLS=~/braincloud-client-master
fi

if ! [ -d "${BRAINCLOUD_TOOLS}/bin" ];
then
    echo "Error: Can't find brainCloud tools in path ${BRAINCLOUD_TOOLS}"
    exit 1
fi

if [ -z $1 ];
then
  if [ -z $SERVER_ENVIRONMENT ];
  then
    SERVER_ENVIRONMENT=internal
  fi
else
  SERVER_ENVIRONMENT=$1
fi

cd "`dirname "$0"`"/..

export WORKSPACE=$PWD

${BRAINCLOUD_TOOLS}/bin/setupexamplesswift.sh $SERVER_ENVIRONMENT 
${BRAINCLOUD_TOOLS}/bin/copy-ids.sh -o "bcchat Example/bcchat/Resources" -p bcchat -x xcconfig -s $SERVER_ENVIRONMENT
