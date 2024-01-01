# Bazel Rules for QuickJS

[![Test](https://github.com/bzlparty/rules_quickjs/actions/workflows/test.yaml/badge.svg?branch=main&event=push)](https://github.com/bzlparty/rules_quickjs/actions/workflows/test.yaml)

## Installation

See install instructions on the [release page](https://github.com/bzlparty/rules_quickjs/releases).

## Usage

In a `BUILD.bazel` file:

```starlark
load("@bzlparty_rules_quickjs//quickjs:qjs.bzl", "qjs_binary")

qjs_binary(
    name = "index",
    entry_point = ":index.js",
)
```

Run `qjs` from Bazel:

```bash
bazel run @bzlparty_quickjs//:qjs
```

## Acknowledgment

- [**quickjs-ng/quickjs**](https://github.com/quickjs-ng/quickjs) `rules_quickjs` depends on the published binaries.

## License

[GNU GPL 3.0](/LICENSE)
