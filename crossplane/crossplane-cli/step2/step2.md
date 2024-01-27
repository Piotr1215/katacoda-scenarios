## Initiate a new Crossplane project

Crossplane uses the concept of
[providers](https://docs.crossplane.io/latest/concepts/providers/) and recently
added [composition
functions](https://docs.crossplane.io/latest/concepts/composition-functions/) as
building blocks empowering compositions to render virtually any infrastructure.

Both providers and functions build upon other abstractions and resulting code
bases can be large and complex in initiate. Thankfully the `crossplane beta xpkg
init`{{}} comes to the rescue!

Running the command without arguments `crossplane beta xpkg init`{{exec}} shows a comprehensive help menu with various options.

## Next Step

Next we will validate a composition using `crossplane beta validate`
