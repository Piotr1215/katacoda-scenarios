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

Since the `function-template-go` template repository has an `init.sh script`, we
could see the details being printed out. We can `v`iew the code of the init
script or execute it and see changes in our repository.

Let's accept the changes to the init script by selecting `y`{{exec}} and clone the _function-template-go_ repository `cd ../ && git clone https://github.com/crossplane/function-template-go.git`{{exec}}
And we can see what changes the init script introduced to our files compared to
the original repository `diff -r --color --suppress-common-lines --ignore-all-space new-func function-template-go`{{exec}}.

## Next Step

Next we will validate a composition using **crossplane beta validate**
