# multi-cluster-of-madness

Dr. Strange has opened up a multiverse rift, allowing countless universes in, your job is to demonstrate a co-existance of these universes. Disasters will occur, and they must be recovered from. But it's not enough to react, we must predict when failures will occur and therefore Dr. Strange must tap into the timestone and see into all possibilites - using monitoring tools of course. 

The multiverse of madness must be kept sane! 

## Requirements
- Each universe is a k8s cluster with at least 1 node
- Universes will experience unique disasters
- These disasters must be recovered from
- A random helm chart will be deployed to each cluster, fully namespaced to just that cluster. The charts can be:
	- [spider-men](#spider-men)
	- [wandavision](#wandavision)
	- [thanos](#thanos)
	- [lokey](#lokey)
	- [tva](#tva) 

# Helm charts
Each cluster recieves a random helm chart app. Each app has a special scenario it will play out, such as rolling deployments, failures, service discovery, and networking.

## spider-men
Creates three spidermen: `parker-1`, `parker-2` and `parker-3`. These will send quips to each other every 1 second.

e.g.:

- `parker-1` -> `parker-3` "I'm gonna put dirt in your eye."
- `parker-3` -> `parker-2` "But I'm Nothing Without This Suit!"
- `parker-2` -> `parker-1` "No One Seems To Grasp The Concept Of The Mask"

Demonstrates:
- Service discovery
- Inter-pod communication

## wandavision
The `wanda` pod persists data in the `vision_db` pod (postgres). The database changes schema over time, and data gets inserted into new tables

1. `1950s`: `vision_db` has database `wandavision` 
2. `1960s`: The table `children` is added to `wandavision`, one column `id`
3. `1970s`: Schema of `children` gets new column `dob`
4. `1980s`: Two rows are added to `children`, and new column. `billy` and `tommy`
5. `1990s`: Table `siblings` is added `wandavision`. Columns id, name. `pietro` is added. children gets new column age, `billy` and `tommy` age set to 5. 
6. -----: Turns out `1990s` is an unstable version. Rollback to 1980s. Attempt to jump straight to `2000s`
7. `2000s`: `vision_db` is deleted

Demonstrates:
- Rolling deployments
- Rollback

## thanos
`thanos` is a menace, every 2 minutes he snaps his fingers — destroying half of the pods. The pods are `life0`, incrementing to a total of 30 pods, `life29`.
```c
At random. Dispassionate, fair to rich and poor alike. They called me a mad man. And what I predicted came to pass.
``` 
## lokey
TODO: Interpod communication with ssl keys

## tva
The `TVA` (`Timeline Variance Authority`) is overseeing a split of the timeline, and must ensure that people are staying within their version of the timeline. The two timelines are called blue and green, and people within blue are referred to as blues, and greens are within green. The green timeline is being prepared and eventually all traffic will start to be routed to the green timeline, whilst the blue timeline will be pruned. 

Demonstrates:
- Blue/Green deployment

Requirements
- A request will be made to the cluster every 2 seconds
- All requests must be handled
- Uptime must be 100%

Tools to use:
- Monitoring
- maxUnavailable, and maxSurge