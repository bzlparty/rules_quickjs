<!-- Generated with Stardoc: http://skydoc.bazel.build -->


# Rules for qjs

```starlark
load("@bzlparty_rules_quickjs//quickjs:defs.bzl", "qjs_binary")
```


<a id="qjs_binary"></a>

## qjs_binary

<pre>
qjs_binary(<a href="#qjs_binary-name">name</a>, <a href="#qjs_binary-data">data</a>, <a href="#qjs_binary-entry_point">entry_point</a>, <a href="#qjs_binary-include_transitive_sources">include_transitive_sources</a>, <a href="#qjs_binary-qjs_args">qjs_args</a>)
</pre>

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


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="qjs_binary-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="qjs_binary-data"></a>data |  Runtime dependencies of the program.<br><br>        The transitive closure of the <code>data</code> dependencies will be available in         the .runfiles folder for this binary/test.<br><br>        NB: <code>data</code> files are copied to the Bazel output tree before being passed         as inputs to runfiles. See <code>copy_data_to_bin</code> docstring for more info.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |
| <a id="qjs_binary-entry_point"></a>entry_point |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="qjs_binary-include_transitive_sources"></a>include_transitive_sources |  When True, <code>transitive_sources</code> from <code>JsInfo</code> providers in <code>data</code> targets are included in the runfiles of the target.   | Boolean | optional | <code>True</code> |
| <a id="qjs_binary-qjs_args"></a>qjs_args |  List of arguments passed to the qjs binary   | List of strings | optional | <code>[]</code> |


<a id="qjs_test"></a>

## qjs_test

<pre>
qjs_test(<a href="#qjs_test-name">name</a>, <a href="#qjs_test-data">data</a>, <a href="#qjs_test-entry_point">entry_point</a>, <a href="#qjs_test-include_transitive_sources">include_transitive_sources</a>, <a href="#qjs_test-qjs_args">qjs_args</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="qjs_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="qjs_test-data"></a>data |  Runtime dependencies of the program.<br><br>        The transitive closure of the <code>data</code> dependencies will be available in         the .runfiles folder for this binary/test.<br><br>        NB: <code>data</code> files are copied to the Bazel output tree before being passed         as inputs to runfiles. See <code>copy_data_to_bin</code> docstring for more info.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |
| <a id="qjs_test-entry_point"></a>entry_point |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="qjs_test-include_transitive_sources"></a>include_transitive_sources |  When True, <code>transitive_sources</code> from <code>JsInfo</code> providers in <code>data</code> targets are included in the runfiles of the target.   | Boolean | optional | <code>True</code> |
| <a id="qjs_test-qjs_args"></a>qjs_args |  List of arguments passed to the qjs binary   | List of strings | optional | <code>[]</code> |


