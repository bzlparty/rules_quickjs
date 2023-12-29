QuickjsInfo = provider(
    fields = {
        "executable_path": "Path to executable",
    },
)

def _quickjs_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        quickjsinfo = QuickjsInfo(
            executable_path = ctx.file.executable.path,
        ),
    )
    return [toolchain_info]

quickjs_toolchain = rule(
    _quickjs_toolchain_impl,
    attrs = {
        "executable": attr.label(
            mandatory = True,
            executable = True,
            cfg = "exec",
            allow_single_file = True,
        ),
    },
)
