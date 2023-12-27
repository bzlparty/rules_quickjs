#!/usr/bin/env bash
#

for f in $(find ./vendor -name "*.bazel"); do
  echo $f
done;

# git diff --no-index /dev/null vendor/quickjs.BUILD.bazel | tail -n +4 | sed "s|b/vendor/quickjs.||" > vendor/quickjs_build_dot_bazel.patch
