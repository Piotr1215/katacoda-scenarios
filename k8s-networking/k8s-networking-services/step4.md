# Feature: Services Encapsulation

    Services encapsulate and abstract communication mechanism
    from actual workloads running in pods

## Scenario: Deployment scaled up

**Given** there is nginx deployment present in the cluster

`k get deploy -n default`{{execute}}

**And** deployment is exposed using "NodePort" Service

`k get svc -n default`{{execute}}

**When** deployment is scaled up to "5" replicas

`k scale deployment nginx-test --replicas 5`{{execute}}

**Then** page on the same NodePort in "killercoda" is accessible without
disruptions

`echo $PORT`{{execute}}

Navigate to [Ports Page]({{TRAFFIC_SELECTOR}}) and paste port copied from
previous command

**And** 5 endpoints are registered in the service manifest

`k get endpoints nginxsvc`{{execute}}

or alternatively check out [Octant]({{TRAFFIC_SELECTOR_HOST1_7777}})

## Scenario: Deployment scaled down

**Given** there is nginx deployment present in the cluster

`k get deploy -n default`{{execute}}

**And** deployment is exposed using "NodePort" Service

`k get svc -n default`{{execute}}

**When** deployment is scaled up to "1" replica

`k scale deployment nginx-test --replicas 1`{{execute}}

**Then** page on the same NodePort in "killercoda" is accessible without
disruptions

`echo $PORT`{{execute}}

Navigate to [Ports Page]({{TRAFFIC_SELECTOR}}) and
paste port copied from previous command

**And** endpoints are removed from the service manifest leaving only one

`k get endpoints nginxsvc`{{execute}}
