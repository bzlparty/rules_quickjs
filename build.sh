#!/usr/bin/env bash

host=$(uname -s)
NAME=rules_quickjs
TAG=${GITHUB_REF_NAME}
VERSION=${TAG:1}
PREFIX="${NAME}-${VERSION}"
RULES_ARCHIVE="${NAME}-${TAG}.tar.gz"
BINS_ARCHIVE="quickjs-${host,}-$(uname -m).tar.gz"

echo "build: Create QuickJS Binaries"
echo "${PREFIX}" > ./vendor/quickjs/VERSION
make -C ./vendor/quickjs qjs qjsc

echo -n "build: Create Binaries Archive"
tar czf "$BINS_ARCHIVE" -C vendor/quickjs qjs qjsc
BINS_SHA=$(shasum -a 256 $BINS_ARCHIVE | awk '{print $1}')
echo " ... done ($BINS_ARCHIVE: $BINS_SHA)"

echo -n "build: Create Rules Archive"
git archive --format=tar --prefix=${PREFIX}/ ${TAG} | gzip >$RULES_ARCHIVE
RULES_SHA=$(shasum -a 256 $RULES_ARCHIVE | awk '{print $1}')
echo " ... done ($RULES_ARCHIVE: $RULES_SHA)"

echo -n "build: Creaet Release Notes"
cat > release_notes.md <<EOF

## Usage

### Install from BCR

\`\`\`starlark
bazel_dep(name = "bzlparty_rules_quickjs", version = "${VERSION}")
\`\`\`

### Install from Git

\`\`\`starlark
bazel_dep(name = "bzlparty_rules_quickjs")
git_override(
    module_name = "bzlparty_rules_quickjs",
    remote = "git@github.com:bzlparty/rules_quickjs.git",
    commit = "${GITHUB_SHA}",
)
\`\`\`

## Checksums

*${BINS_ARCHIVE}*: ${BINS_SHA}
*${RULES_ARCHIVE}*: ${RULES_SHA}

EOF

echo " ... done"
