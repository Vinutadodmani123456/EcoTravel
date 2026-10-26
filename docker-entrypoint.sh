#!/bin/sh
set -eu

: "${PORT:=8080}"
sed -i "s/<Connector port=\"8080\"/<Connector port=\"$PORT\"/" \
    "$CATALINA_HOME/conf/server.xml"

exec catalina.sh run
