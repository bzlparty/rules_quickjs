load("@aspect_bazel_lib//lib:lists.bzl", "filter")
load("@aspect_rules_js//js:libs.bzl", "js_binary_lib", "js_lib_helpers")

def _qjs_binary_impl(ctx):
    launcher = ctx.actions.declare_file("%s_launcher.sh" % ctx.attr.name)
    entry_point = ctx.file.entry_point
    ctx.actions.write(
        output = launcher,
        content = """
{binary} {entry_point}
      """.format(
            binary = ctx.file._binary.path,
            entry_point = entry_point.path,
        ),
        is_executable = True,
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
        include_declarations = ctx.attr.include_declarations,
        include_npm_linked_packages = ctx.attr.include_npm_linked_packages,
    ).merge(ctx.runfiles(files = [launcher, ctx.file._binary]))

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
    "_binary": attr.label(
        default = "@bzlparty_quickjs//:qjs",
        executable = True,
        cfg = "exec",
        allow_single_file = True,
    ),
}

# Attributes to _steal_ from js_binary
_pick_attrs = [
    "data",
    "include_transitive_sources",
    "include_declarations",
    "include_npm_linked_packages",
    # TODO: enable?
    # "no_copy_to_bin",
    # "copy_data_to_bin"
]

_ATTRS.update(filter(_is_key_in(_pick_attrs), js_binary_lib.attrs.items()))

qjs_binary = rule(
    _qjs_binary_impl,
    attrs = _ATTRS,
    executable = True,
)
