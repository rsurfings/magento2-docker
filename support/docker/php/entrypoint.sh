#!/bin/bash
# Our entrypoint manages both new as existing Magento2 installations.

set -eo pipefail
COMMAND="$@"

# Set hooks
PRE_INSTALL_HOOK="/hooks/pre_install.sh"
PRE_COMPILE_HOOK="/hooks/pre_compile.sh"
POST_INSTALL_HOOK="/hooks/post_install.sh"

# Override the default command
if [ -n "${COMMAND}" ]; then
  echo "ENTRYPOINT: Executing override command"
  exec $COMMAND
else
  # Check if we can connect to the database
  while ! mysqladmin ping -h"${DB_HOST}" --silent; do
    echo "Waiting on database connection.."
    sleep 2
  done

# Run any commands that need to run before code compilation starts
if [ -f "${PRE_INSTALL_HOOK}" ]; then

    echo "HOOKS: Running PRE_INSTALL_HOOK"
    chmod +x "${PRE_INSTALL_HOOK}"
    $PRE_INSTALL_HOOK
fi

# Run any commands that need to run before code compilation starts
if [ -f "${PRE_COMPILE_HOOK}" ]; then
    echo "HOOKS: Running PRE_COMPILE_HOOK"
    chmod +x "${PRE_COMPILE_HOOK}"
    $PRE_COMPILE_HOOK
fi

# Run any post install hooks (e.g. run a database script). You can't interact
# with the Magento API at this point as you need a running webserver.
if [ -f "${POST_INSTALL_HOOK}" ]; then
    echo "HOOKS: Running POST_INSTALL_HOOK"
    chmod +x "${POST_INSTALL_HOOK}"
    $POST_INSTALL_HOOK
fi