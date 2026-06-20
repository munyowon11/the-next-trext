# Security Policy

This repository is a read-only Slurm node status summary utility. Security reports are welcome, but sensitive details must not be posted publicly.

## Supported scope

Current supported scope:

- repository code and documentation;
- sample/synthetic Slurm status input;
- local read-only summary workflow;
- safety-boundary checks.

Out of scope:

- live Slurm control;
- production cluster access;
- customer-private data;
- real production deployments;
- third-party infrastructure not controlled by this repository.

## Reporting a vulnerability or sensitive data exposure

Do not open a public GitHub issue for security vulnerabilities, exposed secrets, customer data, real cluster logs, hostnames, network details, or facility-specific data.

Report privately by email:

- trext.official@gmail.com

Please include:

- affected file, commit, branch, or workflow if known;
- what kind of issue it is: secret, unsafe code path, data exposure, dependency risk, claim-boundary issue, or documentation issue;
- minimal reproduction steps if safe;
- whether any token, credential, customer data, or cluster/facility detail appears exposed.

Do not include real secrets, private cluster logs, passwords, private keys, or exploit payloads unless explicitly requested through a private channel.

## Maintainer response expectations

The maintainer should:

1. acknowledge receipt when available;
2. triage whether the report involves secrets, customer data, unsafe write paths, dependency risk, or unsupported public claims;
3. rotate or revoke exposed credentials immediately if any credential may have leaked;
4. remove exposed sensitive material from the repository where possible;
5. treat forks, clones, caches, and logs as potentially still exposed;
6. publish only a minimal public fix note when disclosure is safe.

## Public claim boundary

Security or safety fixes must not be described as proof of production readiness, customer validation, facility deployment, autonomous control safety, guaranteed improvement, certification, or compliance.

Use `docs/PUBLIC_REPOSITORY_OPERATOR_GUIDE.md` before publishing any security-related statement.
