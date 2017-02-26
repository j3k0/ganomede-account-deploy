# Fovea Account Deploy

Deploy an account server on a mesos cluster.

## Requirements

A mesos/marathon cluster deployed with fovea-marathon-base.

At least 3 mesos-agents connected, running on different machines (because we use statically allocated port numbers).

Minimum resources per agent:

 - 16GB RAM
 - 2 CPUs
 - 128GB HDD

## What's in here?

Playbook deploy.yml will deploy a account server comprised of:

 - ganomede-directory
 - ganomede-avatars
 - ganomede-events
 - ganomede-data
 - ganomede-usermeta
 - ganomede-admin
 - CouchDB servers -- 2 instances bi-directionally replicated
   - accounts
   - avatars
 - CouchDB load-balancer (haproxy)
 - Redis servers -- 2 instances each in master-slave mode
   - auth-tokens
   - usermeta
   - events
   - data
 - Redis load-balancer
 - Redis sentinels -- 3 instances

