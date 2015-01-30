#!/bin/bash

# check system environment, java8 is required
tpj=`type -p java`

if [[ "$tpj" ]]; then
  _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]]; then
  _java="$JAVA_HOME/bin/java"
else
  echo "Error: java8 is required."
  exit 1
fi

if [[ "$_java" ]]; then
  version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
else
  echo "Error: java8 is required."
  exit 1
fi

if [[ "$version" < "1.8" ]]; then
  echo "Error: java8 is required."
  exit 1
fi

# TODO
