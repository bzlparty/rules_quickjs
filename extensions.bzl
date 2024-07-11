"Module Extensions"

load("@bzlparty_tools//lib:defs.bzl", "register_platform_toolchains")
load("@bzlparty_tools//vendor/aspect_bazel_lib:extension_utils.bzl", "extension_utils")
load("//quickjs/toolchains:qjs_assets.bzl", QJS_ASSETS = "ASSETS")
load("//quickjs/toolchains:qjsc_assets.bzl", QJSC_ASSETS = "ASSETS")

def _toolchains_extension_impl(ctx):
    extension_utils.toolchain_repos_bfs(
        mctx = ctx,
        get_version_fn = lambda _: "0.5.0",
        get_tag_fn = lambda tags: tags.qjs,
        toolchain_name = "qjs",
        toolchain_repos_fn = lambda name, version: register_platform_toolchains(name = name, assets = QJS_ASSETS, toolchain_type = "@bzlparty_rules_quickjs//quickjs:qjs_toolchain_type"),
    )

    extension_utils.toolchain_repos_bfs(
        mctx = ctx,
        get_version_fn = lambda _: "0.5.0",
        get_tag_fn = lambda tags: tags.qjsc,
        toolchain_name = "qjsc",
        toolchain_repos_fn = lambda name, version: register_platform_toolchains(name = name, assets = QJSC_ASSETS, toolchain_type = "@bzlparty_rules_quickjs//quickjs:qjsc_toolchain_type"),
    )

toolchains = module_extension(
    _toolchains_extension_impl,
    tag_classes = {
        "qjs": tag_class(attrs = {
            "name": attr.string(default = "qjs"),
        }),
        "qjsc": tag_class(attrs = {
            "name": attr.string(default = "qjsc"),
        }),
    },
)
