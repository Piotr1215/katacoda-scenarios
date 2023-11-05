## Function Template

> Read more about [using function templates](https://docs.crossplane.io/knowledge-base/guides/write-a-composition-function-in-go/#initialize-the-function-from-a-template) in the Crossplane Composition
> Functions documentation

Initializing a new functions clones the function's template;

`crossplane beta xpkg init function-example function-template-go -d function-example-test`{{exec}}

The above command creates a new directory <kbd>function-example-test</kbd> with
all the required files:

`tree function-example-test`{{exec}}

> To explore the files in more detail click on the `Editor` tab.
