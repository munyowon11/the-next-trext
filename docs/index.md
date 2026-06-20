# TREXT sample evidence packet

TREXT is currently a small, read-only sample project for reviewing Slurm-style node status output.

It is intended for narrow technical feedback from HPC / Slurm operators and infrastructure reviewers.

## What this page is

This page is a reviewer-facing overview for the current sample repository.

It is not a product landing page, sales page, pilot announcement, deployment proof, customer validation, production-readiness claim, or savings claim.

## Current stage

Status: pre-validation / evidence-base hardening.

The current repository demonstrates a sample-only workflow that reads repository fixtures and produces review artifacts for human inspection.

It does not connect to a live Slurm cluster or facility system.

## What TREXT currently does

Current sample workflow:

1. reads synthetic/sample `sinfo` and `sinfo -R` style text;
2. summarizes node-state counts;
3. identifies unavailable/problem-node reason context when present;
4. separates observed facts, missing evidence, assumptions, and unknowns;
5. rejects unsafe claims that are not supported by evidence.

## What to review first

For a fast review, inspect these files in order:

1. [`README.md`](../README.md) - repository purpose and safety boundary;
2. [`docs/evidence-packet-sample.md`](evidence-packet-sample.md) - sample evidence packet;
3. [`docs/operator-feedback-request.md`](operator-feedback-request.md) - questions for reviewers;
4. [`examples/sinfo_sample.txt`](../examples/sinfo_sample.txt) - sample node-state input;
5. [`examples/sinfo_R_sample.txt`](../examples/sinfo_R_sample.txt) - sample unavailable-node reason input.

## Sample evidence packet summary

The current sample evidence packet shows how a Slurm node-status review can separate:

- observed facts;
- missing evidence;
- human review questions;
- explicit limitations.

Example current finding:

- sample data contains 7 nodes;
- 1 sample node is in `drain` state;
- the packet does not determine root cause because key evidence is missing.

## Safety boundary

TREXT is read-only by default.

This sample does not:

- connect to a live cluster;
- run Slurm commands;
- change Slurm configuration;
- drain, resume, reboot, or modify nodes;
- upload cluster data;
- request private logs or production exports;
- diagnose root cause;
- claim cost, energy, cooling, or reliability improvement;
- claim production readiness;
- claim customer validation;
- claim ASHRAE certification, compliance, endorsement, or official validation.

Human review is required before any operational action.

## Feedback requested

The next validation target is one credible technical reviewer response, not a sale, deployment, pilot, or customer-validation claim.

Useful feedback:

1. Is the sample `sinfo` / `sinfo -R` style input realistic enough for first review?
2. Are the node-state counts and unavailable-node reasons clear?
3. What fields are missing before this could be useful as a review aid?
4. What should a tool like this never infer automatically?
5. Would thermal, power, or cooling context matter only after the Slurm-side evidence packet is trustworthy?

Please do not send real cluster logs, private node names, screenshots, credentials, or production exports. High-level comments or synthetic examples are enough.

## Evidence status

Proven:

- this repository contains a read-only Slurm sample workflow;
- sample evidence-packet documentation exists;
- CI sample checks have passed in the repository history.

Simulated:

- current input and output are sample-mode only.

Assumed:

- HPC / Slurm operators may value a clearer node-state incident review packet.

Unknown:

- whether operators find the current output useful;
- which fields are required before it becomes useful;
- whether cooling, power, or thermal context should be added later.

## Next smallest step

Ask one HPC / Slurm operator or infrastructure reviewer to inspect the sample evidence packet and answer the feedback questions above.

Do not broaden the project into cooling/energy replay until reviewer feedback gives a specific reason.
