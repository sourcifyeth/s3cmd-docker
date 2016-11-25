s3cmd-docker
============

## Credits

This repo is based on [sekka1/docker-s3cmd](https://github.com/sekka1/docker-s3cmd), but we modified the way it works quite heavily.

## Badges

[![GitHub forks](https://img.shields.io/github/forks/hochzehn/s3cmd-docker.svg)](https://github.com/hochzehn/s2/network)
[![GitHub stars](https://img.shields.io/github/stars/hochzehn/s3cmd-docker.svg)](https://github.com/hochzehn/s2/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/hochzehn/s3cmd-docker.svg)](https://github.com/hochzehn/s3cmd-docker/issues)
[![Twitter](https://img.shields.io/twitter/url/https/github.com/hochzehn/s3cmd-docker.svg?style=social)](https://twitter.com/intent/tweet?text=S3cmd%20in%20a%20%40Docker%20container:&url=https://github.com/hochzehn/s3cmd-docker)
[![Docker Pulls](https://img.shields.io/docker/pulls/hochzehn/s3cmd.svg)](https://hub.docker.com/r/hochzehn/s3cmd/)
[![Docker Stars](https://img.shields.io/docker/stars/hochzehn/s3cmd.svg)](https://hub.docker.com/r/hochzehn/s3cmd/)

## What is this?

[s3cmd](https://github.com/s3tools/s3cmd) in a Docker container. This is useful if you are already using Docker.
You can simply pull this container to that Docker server and move things between the local box and S3 by just running
a container.

Using [Alpine linux](https://hub.docker.com/_/alpine/). This image is ~30MB.

You can find an automated build of this container on the Docker Hub: [hochzehn/s3cmd](https://hub.docker.com/r/hochzehn/s3cmd/)

# How to use

## Copy from local to S3:

    AWS_KEY=<YOUR AWS KEY>
    AWS_SECRET=<YOUR AWS SECRET>
    BUCKET=s3://your-bucket-name/
    LOCAL_FILE=/tmp/database

    docker run --rm \
      --env aws_key=${AWS_KEY} \
      --env aws_secret=${AWS_SECRET} \
      --env cmd=sync-local-to-s3 \
      --env DEST_S3=${BUCKET}  \
      -v ${LOCAL_FILE}:/opt/src \
      hochzehn/s3cmd

* Change `LOCAL_FILE` to file/folder you want to upload to S3

## Copy from S3 to local:

    AWS_KEY=<YOUR AWS KEY>
    AWS_SECRET=<YOUR AWS SECRET>
    BUCKET=s3://your-bucket-name/
    LOCAL_FILE=/tmp

    docker run --rm \
      --env aws_key=${AWS_KEY} \
      --env aws_secret=${AWS_SECRET} \
      --env cmd=sync-s3-to-local \
      --env SRC_S3=${BUCKET} \
      -v ${LOCAL_FILE}:/opt/dest \
      hochzehn/s3cmd

* Change `LOCAL_FILE` to the file/folder where you want to download the files from S3 to the local computer

## Run any `s3cmd` command

    AWS_KEY=<YOUR AWS KEY>
    AWS_SECRET=<YOUR AWS SECRET>

    docker run -rm \
      --env aws_key=${AWS_KEY} \
      --env aws_secret=${AWS_SECRET} \
      hochzehn/s3cmd \
      ls /
