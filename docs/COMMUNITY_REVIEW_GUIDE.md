# Community Review Guide

This guide is for HPC / Slurm operators reviewing `trext-node-summary`.

The goal is narrow: check whether a read-only summary of sample Slurm node status is useful, safe, and clear.

This is not a production system, not a live cluster integration, and not an operational recommendation engine.

## Current scope

The repository currently provides:

- sample `sinfo`-style input;
- a local read-only shell script;
- a node-state count summary;
- review notes for human operators;
- explicit limitations.

The repository does not:

- connect to a live Slurm cluster;
- run Slurm commands;
- modify Slurm configuration;
- change node state;
- upload cluster data;
- determine root cause;
- claim cost, reliability, or operational improvement.

## What feedback is useful

Please focus feedback on the operational usefulness of the sample summary.

Useful questions:

1. Is the sample `sinfo` input format realistic enough for a first review?
2. Are the state labels and counts clear?
3. Which node states are missing or oversimplified?
4. Should the summary distinguish `drain`, `drained`, and `draining`?
5. What additional fields would an operator expect before reviewing a node issue?
6. What wording would make the output safer or clearer?
7. What should the tool never infer automatically?
8. What data should never be requested in a public example?

## Suggested next sample fields

Future sample-only examples may include non-sensitive versions of:

- unavailable-node reason;
- reason timestamp;
- partition name;
- node count;
- node state;
- node list;
- human review questions.

All examples must remain synthetic or clearly non-sensitive.

## Review boundary

A good community review should answer:

- Is this safe as a read-only example?
- Is the output understandable?
- Is the summary useful enough to continue improving?
- What should be removed before any real operator would trust it?

A good review should not require:

- real cluster logs;
- private node names;
- user data;
- account information;
- credentials;
- production exports;
- screenshots of internal systems.

## Maintainer response rule

When feedback is received, classify it as one of:

- safe documentation improvement;
- sample parser improvement;
- missing field request;
- safety boundary concern;
- unsupported claim risk;
- out of scope for this repository.

No Evidence = No Claim.  
No Private Data = Safer Review.  
No Human Review = No Operational Action.
