# Bazel Rules for QuickJS

[![Test](https://github.com/bzlparty/rules_quickjs/actions/workflows/test.yaml/badge.svg?branch=main&event=push)](https://github.com/bzlparty/rules_quickjs/actions/workflows/test.yaml)

This project brings [quickjs-ng/quickjs](https://github.com/quickjs-ng/quickjs) to Bazel!
Inspired by (and based on) [rules_js](https://github.com/aspect-build/rules_js), it lets you run JavaScript with `qjs` under Bazel.

> [!NOTE]
> Since the archives taken from quickjs-ng only include the interpreter binary, there is no support for the QuickJS compiler (`qjsc`), yet.

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

See the [documentation](/docs/qjs.md) for more details.

Run `qjs` from Bazel:

```bash
bazel run @bzlparty_quickjs//:qjs
```

## Development

Install git hooks:

```bash
pre-commit install
```

## License

[GNU LGPL 3.0](/LICENSE)
