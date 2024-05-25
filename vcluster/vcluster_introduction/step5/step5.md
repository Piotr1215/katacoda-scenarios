Create a new vcluster named `new-vcluster` in the `new-namespace` namespace.
Make sure not to connect to the `vcluster` after creating it.

### Solution

<details>
<summary>click to see the answer</summary>
<code>vcluster create new-vcluster --namespace new-namespace --connect=false</code>
</details>
