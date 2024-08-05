# Bazel Rules for QuickJS

[![Test](https://github.com/bzlparty/rules_quickjs/actions/workflows/test.yaml/badge.svg?branch=main&event=push)](https://github.com/bzlparty/rules_quickjs/actions/workflows/test.yaml)
[![Release](https://img.shields.io/github/v/release/bzlparty/rules_quickjs?label=Release)](https://github.com/bzlparty/rules_quickjs/releases/latest)

This project brings [quickjs-ng/quickjs](https://github.com/quickjs-ng/quickjs) to Bazel!
Inspired by (and based on) [rules_js](https://github.com/aspect-build/rules_js), it lets you run JavaScript with `qjs` under Bazel.

## Installation

See install instructions on the [release page](https://github.com/bzlparty/rules_quickjs/releases).

## Usage

In a `BUILD.bazel` file:

```starlark
load("@bzlparty_rules_quickjs//quickjs:defs.bzl", "qjs_binary")

qjs_binary(
    name = "index",
    entry_point = ":index.js",
)
```

See the [rules documentation](/docs/rules.md) for more details.

Run `qjs` from Bazel:

```bash
bazel run @bzlparty_quickjs//:qjs
```

## License

Copyright Contributors to the bzlparty project.

Unless otherwise specified, source code in this repository is licensed under the GNU Lesser General Public License, Version 3 or later (LGPL-3.0-or-later). A copy is included in the `LICENSE` file.

Other licenses may be specified as well for certain files or where third-party components are used.
