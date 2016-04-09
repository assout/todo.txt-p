#!/bin/bash -ue

usage() {
  echo "    $(basename "$0") ITEM#"
  echo "      Start p with item name."
}

if ! type p ; then
  exit 1
fi

if [ "$1" = "usage" ] || [ $# != 2 ] ; then
  usage
  exit 1
fi
shift

# shellcheck disable=SC2034
errmsg="usage: $TODO_SH $(basename "$0") ITEM#"
item="$1"
getTodo "$item" && :

# shellcheck disable=SC2154
p start "${todo}"

