## Introduction

Before we start exploring _vcluster_, let's understand what it is and what benefits it provides.

> Definition: Virtual clusters are fully functional Kubernetes clusters nested inside a physical host cluster providing better isolation and flexibility to support multi-tenancy. Multiple teams can operate independently within the same physical infrastructure while minimizing conflicts, maximizing autonomy, and reducing costs.

source: https://www.vcluster.com/docs

What are the main benefits of using _vcluster_?

![vcluster_mindmap](http://www.plantuml.com/plantuml/proxy?cache=yes&src=https://raw.githubusercontent.com/Piotr1215/cloudrumble/master/diagrams/vcluster_mindmap.puml&fmt=png)

### vCluster Architecture

The architecture of _vcluster_ is very interesting. The central piece is the
_syncer_ component that is responsible for syncing resources between the virtual
and host clusters. 

<details>
<summary>vluster components</summary>
<img src="http://www.plantuml.com/plantuml/proxy?cache=yes&src=https://raw.githubusercontent.com/Piotr1215/cloudrumble/master/diagrams/vcluster-components.puml&fmt=png" alt="vcluster">
<sub>source: author based on https://www.vcluster.com/docs/vcluster/architecture/</sub>
</details>

## Next Step

Next we will install _vcluster_.
