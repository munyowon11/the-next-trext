> **SAMPLE OUTPUT - NOT REAL CLUSTER DATA**
> This file is generated from a local synthetic fixture (`examples/sinfo_sample.txt`).
> It does not represent a real cluster, real nodes, or real operational state.
> No live Slurm integration. No action taken. Human review required before any operation.

# TREXT Sample Evidence Packet

- Data source: `examples/sinfo_sample.txt`
- Mode: local sample replay only
- Generated deterministically from the supplied fixture
- Human review required

## 1. Cluster snapshot summary

The sample contains **7 nodes** across **2 partitions**.

| Node state | Count |
|---|---:|
| Allocated | 2 |
| Idle | 4 |
| Mixed | 0 |
| Drain | 1 |
| Down | 0 |
| Other / unrecognized | 0 |
| **Total** | **7** |

## 2. Suspected issue signals

- **Drain state observed:** 1 node is marked `drain` (gpu-004). This is a review signal, not a root-cause finding.
- Allocated and idle counts are snapshot observations only; they do not establish utilization efficiency or waste.

## 3. Missing data

This input does not include:

- snapshot capture time
- drain or down reason
- node state transition time or prior state
- job queue, pending reason, or job-to-node context
- maintenance window or change history
- hardware, network, storage, and scheduler health evidence

## 4. Review questions for operator

1. Is the observed node state still current, or was it transient?
2. What reason and timestamp are associated with each drain or down node?
3. Was there a maintenance event or configuration change near the state transition?
4. Are queued or running jobs affected?
5. What additional local evidence is safe and useful to add to a sanitized replay fixture?

## 5. Limitations / no-claim boundary

- This packet is generated from a local sample file only.
- It does not connect to Slurm, use SSH, send control commands, or transmit cluster data.
- It does not determine root cause or authorize operational action.
- It does not claim guaranteed savings, autonomous optimization, production readiness, or customer validation.
- The sample may omit conditions present in a real cluster. Human review is required.

## 6. Next action recommendation

For Stage 1 public sample-mode, record missing reason/timestamp evidence as operator review questions only. Approved/anonymized real exports belong to a future private validation stage. Do not take cluster action based on this sample packet.
