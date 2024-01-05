#!/usr/bin/env bash

host=$(uname -s)
NAME=project_name
TAG=${GITHUB_REF_NAME}
VERSION=${TAG:1}
PREFIX="${NAME}-${VERSION}"
RULES_ARCHIVE="${NAME}-${TAG}.tar.gz"

echo -n "build: Create Rules Archive"
git archive --format=tar --prefix=${PREFIX}/ ${TAG} | gzip >$RULES_ARCHIVE
RULES_SHA=$(shasum -a 256 $RULES_ARCHIVE | awk '{print $1}')
echo " ... done ($RULES_ARCHIVE: $RULES_SHA)"

echo -n "build: Creaet Release Notes"
cat > release_notes.md <<EOF

## Installation

> [!IMPORTANT]  
> Installation is only supported via Bzlmod!

Choose from the options below and put as dependency in your `MODULE.bazel`.

### Install from BCR

\`\`\`starlark
bazel_dep(name = "bzlparty_project_name", version = "${VERSION}")
\`\`\`


### Install from Git

\`\`\`starlark
bazel_dep(name = "bzlparty_project_name")

git_override(
    module_name = "bzlparty_project_name",
    remote = "git@github.com:bzlparty/project_name.git",
    commit = "${GITHUB_SHA}",
)
\`\`\`

### Install from Archive

\`\`\`starlark
bazel_dep(name = "bzlparty_project_name")

archive_override(
    module_name = "bzlparty_project_name",
    urls = "https://github.com/bzlparty/project_name/releases/download/${TAG}/${RULES_ARCHIVE}",
    strip_prefix = "${PREFIX}",
    integrity = "sha256-${RULES_SHA}",
)
\`\`\`

## Checksums

**${RULES_ARCHIVE}** ${RULES_SHA}

EOF

echo " ... done"
