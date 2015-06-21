#! /bin/bash
set -e

if [ -z "$(ls -A /master)" ] ; then
    echo "Initializing buildbot master"
    echo "WARNING: default buildbot configuration, you will need to reconfigure"
    buildbot create-master /master
    mv master.cfg.sample master.cfg
    cat >> buildbot.tac <<EOF
import sys
from twisted.python import log
log.FileLogObserver(sys.stdout).start()
EOF
else
    echo "Upgrading buildbot master"
    buildbot upgrade-master -r
fi

exec buildbot start --nodaemon $SLAVE_ARGS
