<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="qjs_binary"></a>

## qjs_binary

<pre>
qjs_binary(<a href="#qjs_binary-name">name</a>, <a href="#qjs_binary-data">data</a>, <a href="#qjs_binary-entry_point">entry_point</a>, <a href="#qjs_binary-include_declarations">include_declarations</a>, <a href="#qjs_binary-include_npm_linked_packages">include_npm_linked_packages</a>,
           <a href="#qjs_binary-include_transitive_sources">include_transitive_sources</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="qjs_binary-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="qjs_binary-data"></a>data |  Runtime dependencies of the program.<br><br>        The transitive closure of the <code>data</code> dependencies will be available in         the .runfiles folder for this binary/test.<br><br>        NB: <code>data</code> files are copied to the Bazel output tree before being passed         as inputs to runfiles. See <code>copy_data_to_bin</code> docstring for more info.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |
| <a id="qjs_binary-entry_point"></a>entry_point |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="qjs_binary-include_declarations"></a>include_declarations |  When True, <code>declarations</code> and <code>transitive_declarations</code> from <code>JsInfo</code> providers in data targets are included in the runfiles of the target.<br><br>        Defaults to false since declarations are generally not needed at runtime and introducing them could slow down developer round trip         time due to having to generate typings on source file changes.   | Boolean | optional | <code>False</code> |
| <a id="qjs_binary-include_npm_linked_packages"></a>include_npm_linked_packages |  When True, files in <code>npm_linked_packages</code> and <code>transitive_npm_linked_packages</code> from <code>JsInfo</code> providers in data targets are included in the runfiles of the target.<br><br>        <code>transitive_files</code> from <code>NpmPackageStoreInfo</code> providers in data targets are also included in the runfiles of the target.   | Boolean | optional | <code>True</code> |
| <a id="qjs_binary-include_transitive_sources"></a>include_transitive_sources |  When True, <code>transitive_sources</code> from <code>JsInfo</code> providers in data targets are included in the runfiles of the target.   | Boolean | optional | <code>True</code> |


