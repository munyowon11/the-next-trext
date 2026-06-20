# TREXT — Slurm Node Status Summary (Sample Mode)

TREXT is a read-only tool that parses sample `sinfo` output and produces an evidence packet: a structured Markdown document listing observed node states, missing data, and review questions for the operator.

This is a sample-mode MVP. It runs against a local text fixture and produces local output only.

## What it does

- Reads a sample `sinfo` text file from `examples/sinfo_sample.txt`
- Counts node states: idle, alloc, drain, down, mixed, other
- Lists drain and down node names as review signals
- Writes a structured evidence packet to `dist/evidence_packet.md`
- Prints the packet to stdout

## What it does not do

- Connect to a live Slurm cluster
- Use SSH, srun, scontrol, or any Slurm command
- Upload or transmit cluster data
- Accept real cluster input
- Drain, resume, reboot, or modify nodes
- Determine root cause automatically
- Claim cost savings, autonomous optimization, production readiness, or customer validation

Human review is required before taking any operational action.

## Quick start

```bash
bash scripts/trext-node-summary.sh
```

Output goes to `dist/evidence_packet.md` and is also printed to stdout.

To review the sample input before running:

```
examples/sinfo_sample.txt
```

To see a pre-generated example of the output:

```
docs/evidence-packet-sample.md
```

## Additional commands

```bash
bash scripts/trext.sh replay                    # same as trext-node-summary.sh
bash scripts/trext.sh report slurm-node-reasons # parse sinfo -R style reason rows
bash scripts/trext.sh evidence-index            # SHA-256 index of examples/docs/reports
bash scripts/trext.sh check-boundary            # scan for forbidden claim phrases
```

All commands use repository fixtures only. None connect to a cluster.

## Safety boundary

This tool is read-only by design. Any output it generates is a review aid, not an operational decision or automated control signal. Human review is required before taking any operational action.

## Community review

This repository is seeking narrow technical feedback from HPC and Slurm operators. Useful feedback addresses whether the sample `sinfo` format is realistic, which node states or fields are missing, and what this tool should never infer automatically.

See [`docs/COMMUNITY_REVIEW_GUIDE.md`](docs/COMMUNITY_REVIEW_GUIDE.md).

Do not share real node names, account information, credentials, screenshots of internal systems, or production cluster exports.

## Repository documentation

- [`docs/evidence-packet-sample.md`](docs/evidence-packet-sample.md) — example of the evidence packet this tool produces
- [`docs/COMMUNITY_REVIEW_GUIDE.md`](docs/COMMUNITY_REVIEW_GUIDE.md) — how to give feedback
- [`docs/PUBLIC_REPOSITORY_OPERATOR_GUIDE.md`](docs/PUBLIC_REPOSITORY_OPERATOR_GUIDE.md) — public-release precautions
- [`docs/PUBLIC_SHARING_CHECKLIST.md`](docs/PUBLIC_SHARING_CHECKLIST.md) — required gate before public sharing
- [`SECURITY.md`](SECURITY.md) — private reporting route for sensitive-data concerns
- [`CONTRIBUTING.md`](CONTRIBUTING.md) — contribution rules that preserve read-only and no-claim boundaries
