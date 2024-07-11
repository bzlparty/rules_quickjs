"""
# Rules for qjs

```starlark
load("@bzlparty_rules_quickjs//quickjs:defs.bzl", "qjs_binary")
```
"""

load("@aspect_bazel_lib//lib:lists.bzl", "filter")
load("@aspect_rules_js//js:libs.bzl", "js_binary_lib", "js_lib_helpers")
load(
    "@bzlparty_tools//lib:defs.bzl",
    "write_executable_launcher_file",
)

QJS_TOOLCHAIN_TYPE = "@bzlparty_rules_quickjs//quickjs:qjs_toolchain_type"

def _qjs_binary_impl(ctx):
    qjs = ctx.toolchains[QJS_TOOLCHAIN_TYPE].binary_info.binary
    entry_point = ctx.file.entry_point
    launcher = write_executable_launcher_file(
        ctx,
        content = """
#!/usr/bin/env bash
{binary} {qjs_args} {entry_point} $@
      """.format(
            binary = qjs.path,
            entry_point = entry_point.path,
            qjs_args = " ".join(ctx.attr.qjs_args),
        ),
    )

    runfiles = js_lib_helpers.gather_runfiles(
        ctx = ctx,
        sources = [],
        data = ctx.attr.data,
        data_files = [entry_point] + ctx.files.data,
        deps = [],
        # TODO: enable?
        # copy_data_files_to_bin = ctx.attr.copy_data_to_bin,
        # no_copy_to_bin = ctx.files.no_copy_to_bin,
        include_transitive_sources = ctx.attr.include_transitive_sources,
    ).merge(ctx.runfiles(files = [launcher, qjs]))

    return [
        DefaultInfo(
            executable = launcher,
            runfiles = runfiles,
        ),
    ]

def _is_key_in(arr):
    return lambda i: i[0] in arr

_ATTRS = {
    "entry_point": attr.label(
        mandatory = True,
        allow_single_file = True,
    ),
    "qjs_args": attr.string_list(
        doc = "List of arguments passed to the qjs binary",
        default = [],
    ),
}

# Attributes to _steal_ from js_binary
_pick_attrs = [
    "data",
    "include_transitive_sources",
    # TODO: enable?
    # "no_copy_to_bin",
    # "copy_data_to_bin"
]

_ATTRS.update(filter(_is_key_in(_pick_attrs), js_binary_lib.attrs.items()))
_DOCS = """\
Execute a JavaScript program on QuickJS.

```starlark
qjs_binary(
    name = "hello_world",
    entry_point = ":hello_world.js",
)
```

Run the target:

```bash
bazel run //path/to:hello_world
```

`qjs_binary` is meant to be similar to [`js_binary`]() and therefore shares some of its attributes.
"""

_TOOLCHAINS = [QJS_TOOLCHAIN_TYPE]

qjs_binary = rule(
    _qjs_binary_impl,
    doc = _DOCS,
    attrs = _ATTRS,
    toolchains = _TOOLCHAINS,
    executable = True,
)

qjs_test = rule(
    _qjs_binary_impl,
    attrs = _ATTRS,
    toolchains = _TOOLCHAINS,
    test = True,
)
