#!/usr/bin/env bash

DEST="$(pwd)/dist"
TAG=${GITHUB_REF_NAME:-main}

export DEST

bazel run \
  --@bzlparty_tools//lib:release_dir="$DEST" \
  --@bzlparty_tools//lib:release_tag="$TAG" \
  //scripts/release:release_notes
