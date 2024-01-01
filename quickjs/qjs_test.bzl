"qjs test suite"

load("@bazel_skylib//lib:unittest.bzl", "analysistest", "asserts")
load("@bazel_skylib//rules:write_file.bzl", "write_file")
load(":qjs.bzl", "qjs_binary")

def _create_launcher_test_impl(ctx):
    env = analysistest.begin(ctx)
    launcher_file = analysistest.target_actions(env)[0].outputs.to_list()[0].basename
    asserts.equals(env, launcher_file, "qjs_test_launcher.sh")
    return analysistest.end(env)

create_launcher_test = analysistest.make(_create_launcher_test_impl)

def qjs_test_suite(name = "qjs_test"):
    create_launcher_test(
        name = "create_launcher_test",
        target_under_test = ":qjs_test",
    )

    write_file(
        name = "index_js",
        out = "index.js",
        content = [
            "print('Hello, World!');",
        ],
    )

    qjs_binary(
        name = name,
        entry_point = ":index.js",
    )
