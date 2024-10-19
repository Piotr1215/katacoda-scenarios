## Data storage

Vcluster by default stores data in a _sqlite_ database. This database is stored
directly in the _vcluster_ pod. A key _vcluster_ component called _syncer_ is
responsible for syncing the resources between the virtual and host clusters.

First let's copy the database file from the _vcluster_ to the current folder.

```bash
kubectl cp test-namespace/my-vcluster-0:/data/state.db ./state.db -c syncer
```{{exec}}

All the interesting data is stored in the _state.db_ file. We can use _sqlite3_
to retrieve all data that _vcluster_ stores.

```bash
sqlite3 state.db "SELECT * FROM kine WHERE name LIKE '%nginx%';"
```{{exec}}

Here we can find our nginx pod and service and other data synchronized by _vcluster_.

## Next Step

Next we will see how well you have mastered the _vcluster_ CLI by running some
test scenarios.
