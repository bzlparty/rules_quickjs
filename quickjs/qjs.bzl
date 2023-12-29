def _qjs_binary_impl(ctx):
    launcher = ctx.actions.declare_file("%s_launcher.sh" % ctx.attr.name)
    ctx.actions.write(
        output = launcher,
        content = """
{binary} {entry_point}
      """.format(
            binary = ctx.file._binary.path,
            entry_point = ctx.file.entry_point.path,
        ),
        is_executable = True,
    )

    runfiles = ctx.runfiles(
        files = [launcher, ctx.file._binary, ctx.file.entry_point] + ctx.files.data,
    )
    return [
        DefaultInfo(
            files = depset([launcher]),
            executable = launcher,
            runfiles = runfiles,
        ),
    ]

qjs_binary = rule(
    _qjs_binary_impl,
    attrs = {
        "entry_point": attr.label(
            mandatory = True,
            allow_single_file = True,
        ),
        "data": attr.label_list(
            mandatory = False,
            allow_files = True,
        ),
        "_binary": attr.label(
            default = "@bzlparty_quickjs//:qjs",
            executable = True,
            cfg = "exec",
            allow_single_file = True,
        ),
    },
    executable = True,
)
