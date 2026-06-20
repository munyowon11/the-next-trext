# Contributing

Thank you for considering a contribution.

This repository is currently a read-only Slurm node status summary utility. Contributions must preserve the safety and claim boundaries of the project.

## Contribution rules

Before opening an issue or pull request, confirm that your contribution does not include:

- secrets, API keys, tokens, passwords, cookies, SSH keys, private keys, `.env` files, or credentials;
- customer-private data, real cluster logs, Slurm exports from private environments, device identifiers, hostnames, internal network details, or screenshots of private systems;
- personal data such as names, emails, phone numbers, account IDs, or incident evidence;
- unsupported claims about reliability improvement, savings, production deployment, customers, pilots, PMF, certification, external endorsement, or investment readiness;
- code paths that write to external systems, control Slurm, modify nodes, call live cluster APIs, or require privileged production access.

## What contributions are welcome now

Good-fit contributions:

- safer documentation;
- clearer claim-boundary wording;
- tests for read-only sample parsing;
- synthetic/sample data improvements;
- parser improvements that remain local and read-only;
- report output consistency checks;
- issue reports about confusing wording or missing assumptions.

Not accepted at this stage:

- live-control integrations;
- customer-private datasets;
- production deployment claims;
- unreviewed benchmark, reliability, or savings claims;
- features requiring secrets or write access by default.

## Pull request checklist

Every PR should answer:

1. Does this change remain read-only?
2. Does it avoid secrets and customer-private data?
3. Does it use only sample, synthetic, public, anonymized, or explicitly approved non-sensitive data?
4. Does it avoid unsupported product, customer, market, savings, pilot, certification, or deployment claims?
5. Does it preserve human review for operational interpretation?
6. Were tests or validation commands run, or is the missing validation clearly stated?

## Public issue guidance

Public issues are for non-sensitive bugs, documentation questions, and safe feature discussion.

Do not post sensitive security reports, real credentials, private logs, customer or facility information, account compromise evidence, or screenshots with private data.

For sensitive reports, follow `SECURITY.md`.

## Evidence language

Use precise labels:

- `proven` only when evidence is committed and reproducible;
- `simulated` for synthetic or sample-only output;
- `estimated` for assumption-based calculations;
- `assumed` for stated assumptions;
- `unknown` when evidence is missing.

Default rule:

> No Evidence = No Claim.
