#! /bin/bash
set -e

: ${MASTER:?"Required environment variable unset"}
: ${SLAVE_NAME:?"Required environment variable unset"}
: ${SLAVE_PASSWORD:?"Required environment variable unset"}

if [ -z "$(ls -A /slave)" ] ; then
    echo "Initializing buildslave"
    buildslave create-slave -r /slave "$MASTER" "$SLAVE_NAME" "$SLAVE_PASSWORD"
    cat >> /slave/buildbot.tac <<EOF
import sys
from twisted.python import log
log.FileLogObserver(sys.stdout).start()
EOF
    [ -n "$SLAVE_ADMIN" ] && echo "$SLAVE_ADMIN" > /slave/info/admin
    [ -n "$SLAVE_DESCRIPTION" ] && echo "$SLAVE_DESCRIPTION" > /slave/info/host
    chown buildbot.buildbot -R /slave
else
    echo "Upgrading buildbot slave"
    buildslave upgrade-slave /slave
fi

exec buildslave start --nodaemon $SLAVE_ARGS
