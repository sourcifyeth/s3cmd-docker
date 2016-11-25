#!/bin/sh -e

#
# main entry point to run s3cmd
#
S3CMD_PATH=/opt/s3cmd/s3cmd
S3CMD_CONFIG=/root/.s3cfg

#
# Check for required parameters
#
if [ -z "${aws_key}" ]; then
    echo "ERROR: The environment variable key is not set."
    exit 1
fi

if [ -z "${aws_secret}" ]; then
    echo "ERROR: The environment variable secret is not set."
    exit 1
fi

if [ -z "${cmd}" ]; then
    echo "ERROR: The environment variable cmd is not set."
    exit 1
fi

#
# Set user provided key and secret in .s3cfg file
#
echo "" >> "$S3CMD_CONFIG"
echo "access_key=${aws_key}" >> "$S3CMD_CONFIG"
echo "secret_key=${aws_secret}" >> "$S3CMD_CONFIG"

#
# Add region base host if it exist in the env vars
#
if [ "${s3_host_base}" != "" ]; then
  sed -i "s/host_base = s3.amazonaws.com/# host_base = s3.amazonaws.com/g" "$S3CMD_CONFIG"
  echo "host_base = ${s3_host_base}" >> "$S3CMD_CONFIG"
fi

# Check if we want to run in interactive mode or not
if [ "${cmd}" != "interactive" ]; then

  #
  # sync-s3-to-local - copy from s3 to local
  #
  if [ "${cmd}" = "sync-s3-to-local" ]; then
      echo ${src-s3}
      ${S3CMD_PATH}  sync ${SRC_S3} /opt/dest/
  fi

  #
  # sync-local-to-s3 - copy from local to s3
  #
  if [ "${cmd}" = "sync-local-to-s3" ]; then
      ${S3CMD_PATH} sync /opt/src/ ${DEST_S3}
  fi
fi

#
# Finished operations
#
echo "Finished s3cmd operations"
