load(":version.bzl", "TOOL_VERSIONS")

def _get_download_url(version, platform):
    ext = ""
    if platform.startswith("windows"):
        ext = ".exe"
    repo = "https://github.com/quickjs-ng/quickjs"
    return "{0}/releases/download/v{1}/qjs-{2}{3}".format(repo, version, platform, ext)

def _get_platform(name, arch):
    if name.startswith("mac"):
        return "darwin"
    return name + "-" + "x86_64" if arch == "amd64" or arch == "x86_64" else "x86"

def _quickjs_repo_impl(repository_ctx):
    version = repository_ctx.attr.version
    platform = _get_platform(repository_ctx.os.name, repository_ctx.os.arch)
    repository_ctx.download(
        output = "qjs",
        url = _get_download_url(version, platform),
        executable = True,
        integrity = TOOL_VERSIONS[version][platform],
    )
    repository_ctx.template("BUILD.bazel", repository_ctx.attr._build_file)

quickjs_repo = repository_rule(
    _quickjs_repo_impl,
    attrs = {
        "version": attr.string(),
        "_build_file": attr.label(
            default = ":quickjs.BUILD.bazel",
            allow_single_file = True,
        ),
    },
)

quickjs_extension = module_extension(
    implementation = lambda _: quickjs_repo(name = "quickjs", version = "0.3.0"),
)
