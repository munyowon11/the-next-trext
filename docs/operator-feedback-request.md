# Operator Feedback Request

This document provides a narrow, safe request for feedback from an HPC / Slurm operator or infrastructure reviewer.

The purpose is not sales, deployment, pilot validation, customer validation, production readiness, or proof of savings. The purpose is to learn whether the current sample evidence packet is useful, safe, and clear enough to keep improving.

## Feedback target

Ask the reviewer to inspect:

- `README.md`
- `docs/COMMUNITY_REVIEW_GUIDE.md`
- `docs/evidence-packet-sample.md`
- `docs/trext-v0.1-market-wedge.md`
- `examples/sinfo_sample.txt`
- `examples/sinfo_R_sample.txt`

Primary question:

> Is this read-only sample evidence packet useful enough for an operator to review again?

## What to ask for

Ask for feedback on:

1. whether the sample `sinfo` and `sinfo -R` style inputs are realistic enough for first review;
2. whether the node-state summary is understandable;
3. whether the evidence packet separates observed facts, missing evidence, assumptions, and unknowns clearly;
4. which fields are missing before an operator could trust the output as a review aid;
5. whether the output wording is safe enough and avoids unsupported diagnosis or savings claims;
6. what data should never be requested in a public sample;
7. whether thermal, power, or cooling context would be useful only after the Slurm-side evidence packet is trustworthy.

## What not to ask for

Do not ask for:

- real cluster logs;
- private node names, hostnames, or device identifiers;
- account names or user data;
- credentials, tokens, cookies, private keys, `.env` files, OAuth material, or SSH material;
- screenshots of internal systems;
- production exports;
- facility-private cooling, BMS, PLC, sensor, chiller, CRAH/CRAC, or power-meter data;
- approval to control infrastructure;
- permission to claim savings, diagnosis, customer validation, production readiness, or compliance.

## Outreach handling

Do not keep ready-to-send outreach copy in this public repository.

Outreach text should be drafted privately for each channel or reviewer. Public repository content should only define safe feedback categories, data boundaries, reviewer response recording, and unsupported-claim limits.
## Reviewer response template

Record responses without adding unsupported claims.

```text
Reviewer type:
Date:
Public/private response:
Permission to quote:

What they found useful:

What was unclear:

Missing fields requested:

Safety or privacy concerns:

Unsupported-claim risks mentioned:

Cooling/energy relevance:

Decision:
- Continue Slurm evidence packet
- Add missing sample field
- Clarify wording only
- Shift wedge
- Stop / no useful signal yet

Evidence status:
- Proven:
- Simulated:
- Assumed:
- Unknown:
```

## Maintainer classification

Classify each response as one or more of:

- safe documentation improvement;
- sample parser improvement;
- missing field request;
- safety boundary concern;
- unsupported claim risk;
- cooling/energy extension signal;
- out of scope for this repository.

## Advancement rule

Do not broaden TREXT from Slurm evidence packet to cooling/energy replay until reviewer feedback gives a specific reason.

Valid reasons may include:

- reviewer says thermal, power, or cooling context is needed to interpret the Slurm evidence packet;
- reviewer names a safe non-sensitive field that can be added to the sample;
- reviewer identifies a concrete operator workflow where the evidence packet would be reviewed.

Invalid reasons include:

- broad market size claims;
- AI/data-center hype;
- assumed savings;
- Netlify/demo availability;
- internal optimism without reviewer evidence.

## Unsafe claims rejected

This feedback request must reject the following claims unless direct evidence is later recorded:

- TREXT has customer validation;
- TREXT has product-market fit;
- TREXT is production-ready;
- TREXT controls live infrastructure;
- TREXT diagnoses root cause;
- TREXT guarantees cost, energy, cooling, or reliability improvement;
- TREXT is ASHRAE certified, compliant, endorsed, or officially validated;
- a reviewer comment equals a pilot, deployment, or purchase intent.

## Next smallest executable step

Ask one HPC / Slurm operator or infrastructure reviewer for narrow technical feedback through a private, channel-specific message and record the response using the reviewer response template.
