#!/bin/bash -ue

usage() {
  echo "    $(basename "$0") ITEM# or $(basename "$0") NEW_TASK_NAME"
  echo "      Start p with item name."
}

if ! type p > /dev/null ; then
  exit 1
fi

if [ "$1" = "usage" ] || [ $# != 2 ] ; then
  usage
  exit 1
fi
shift

# shellcheck disable=SC2034
errmsg="usage: $TODO_SH $(basename "$0") ITEM#"

# TODO: dirty
set +e
expr "$1" + 1 > /dev/null 2>&1
ret=$?
set -e
if [ ${ret} -ge 2 ] ; then
  if "$TODO_SH" command add "$@" ; then
      # getting the number item: it's simply the last item added to the file
      line=`wc -l "$TODO_FILE" | cut -d' ' -f1`
  fi
else
  line=$1
fi
# TODO: dirty
set +u
getTodo "$line" && :
set -u

# shellcheck disable=SC2154
p start "${todo}"

