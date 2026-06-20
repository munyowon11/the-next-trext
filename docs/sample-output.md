# Slurm Node Status Summary

Data source: sample sinfo output  
Mode: read-only  
Human review: required

## Cluster status overview

Total nodes: 7

| State | Count |
|---|---:|
| idle | 4 |
| alloc | 2 |
| drain | 1 |
| down | 0 |
| mix | 0 |

## Review notes

- 1 node is marked as drain.
- Check the drain reason before taking operational action.
- This summary does not determine root cause.
- This summary does not recommend automated action.

## Questions before incident diagnosis

1. Which node is affected?
2. Since when has the node been in this state?
3. Is the state repeated or one-time?
4. Is there a known maintenance window?
5. Is there a related job queue issue?

## Limitations

- Sample data only.
- No live cluster integration.
- No control commands.
- No root-cause claim.
- No cost-saving claim.
