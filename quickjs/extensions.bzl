load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(":version.bzl", "SHA256", "VERSION")

def _get_download_url(version):
    repo = "https://github.com/bzlparty/rules_quickjs"
    archive = "quickjs-linux-x86_64.tar.gz"
    return "{0}/releases/download/v{1}/{2}" % (repo, version, archive)

def _quickjs_extension_impl(_):
    http_archive(
        name = "quickjs-%s" % VERSION,
        url = _get_download_url(VERSION),
        sha256 = SHA256,
    )

quickjs_extension = module_extension(
    _quickjs_extension_impl,
)
