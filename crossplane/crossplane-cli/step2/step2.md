## Initiate a new Crossplane project

Crossplane uses the concept of
[providers](https://docs.crossplane.io/latest/concepts/providers/) and recently
added [composition
functions](https://docs.crossplane.io/latest/concepts/composition-functions/) as
building blocks empowering compositions to render virtually any infrastructure.

Both providers and functions build upon other abstractions and resulting code
bases can be large and complex in initiate. Thankfully the **crossplane beta xpkg init** comes to the rescue!

With Crossplane v.1.15 release the command can now trigger an `init` script as
part of creating a template. The script can do anything from renaming the
project, including file imports and more.

### Quick refresh on how the command works

Running the command without arguments `crossplane beta xpkg init`{{exec}} shows a comprehensive help menu with various options.

Let's create a new folder `mkdir new-func && cd new-func`{{exec}} and run the
init command to create a new function based on the _funciton-sdk-go_.

`crossplane beta xpkg init new-func function-template-go && tree`{{exec}}
prepares for us directory structure with all the necessary boilerplate.

> Use the builtin editor, accessible on the left upper corner on the terminal,
> to view the files.

### The init script

If a template repository has an _init_ script it would be run on the command
execution.

<!-- TODO:(piotr1215) add this when implemented -->

## Next Step

Next we will validate a composition using **crossplane beta validate**
