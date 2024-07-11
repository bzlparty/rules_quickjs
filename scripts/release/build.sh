#!/usr/bin/env bash

COMMIT="${GITHUB_REF_NAME:-main}"
DEST="$(pwd)/dist"

rm -rf "$DEST"; mkdir "$DEST"

bazel run \
  --@bzlparty_tools//lib:release_dir="$DEST" \
  --@bzlparty_tools//lib:release_tag="$COMMIT" \
  //scripts/release:git_archive
