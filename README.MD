# multi-cluster-of-madness

Dr. Strange has opened up a multiverse rift, allowing countless universes in, your job is to demonstrate a co-existance of these universes. Disasters will occur, and they must be recovered from. But it's not enough to react, we must predict when failures will occur and therefore Dr. Strange must tap into the timestone and see into all possibilites - using monitoring tools of course. 

The multiverse of madness must be kept sane! 

# Requirements
- Each universe is a k8s cluster with at least 1 node
- Universes will experience unexpected losses of nodes (thanos snaps)
	- These disasters must be recovered from
- Occassionally universes will also experience a sudden increase in demand (hulk snaps)
	- This is also a disaster, the demand cannot be met with current resources.
- Once every 1 hour, Iron Man will try to create a shield around a world (pod). His deployment will contain buggy code (duh)
	- A disaster if no rollback system is setup
	- Stateful pods will regretfully end up in an inconsistent state, Iron Man must use his time-machine (backup) to recover without losing valuable data
- A randomized helm chart will be deployed to each cluster, fully namespaced to just that cluster. The charts can be:
	- [spider-men](#spider-men)
	- [wandavision](#wandavision)
	- TODO add some more

# Helm charts
Each cluster recieves a random helm chart app. Each app has a special scenario it will play out, such as rolling deployments, failures, service discovery, and networking.

## spider-men
Creates three spidermen: `parker-0`, `parker-1` and `parker-2`. These will send quips to each other every 1 second.

Demonstrates:
- Service discovery
- Inter-pod communication

## wandavision
The `wanda` pod persists data in the `vision_db` pod (postgres). The database changes schema over time, and data gets inserted into new tables

1. 1950: `vision_db` has database `wandavision` 
2. 1960: The table `children` is added to `wandavision`, one column `id`
3. 1970s: Schema of `children` gets new column `dob`
4. 1980s: Two rows are added to `children`, and new column. `billy` and `tommy`
5. 1990s: Table `siblings` is added `wandavision`. Columns id, name. `pietro` is added. children gets new column age, `billy` and `tommy` age set to 5. 
6. -----: Turns out 1990s is an unstable app. Rollback to 1980s. 
7. 2000s: `vision_db` is deleted

