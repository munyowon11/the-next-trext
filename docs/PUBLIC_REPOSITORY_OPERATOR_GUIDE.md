# Public Repository Operator Guide

This guide defines operator behavior and release precautions for this repository.

This repository is a read-only Slurm node status summary utility. It is not a live cluster controller, not a production operations system, and not evidence of operational improvement by itself.

## Operating principle

Public visibility changes the risk model:

- code can be read by anyone;
- forks and local copies can persist outside the maintainer's control;
- Actions logs, workflow history, issue text, PR text, and screenshots may become public;
- public wording can be interpreted as a product, safety, customer, market, or investment claim.

Therefore, public work requires evidence-first, least-disclosure, and claim-boundary discipline.

## Operator behavior rules

### 1. Treat every public file as externally quoted material

Before committing, assume the content may be read by cluster operators, HPC engineers, grant or investment reviewers, future customers, security researchers, competitors, and automated crawlers.

Write only what the repository can prove.

### 2. Preserve the current boundary

Allowed public positioning:

- read-only sample parsing;
- Slurm node status summary;
- sample, synthetic, public, anonymized, or explicitly approved non-sensitive input only;
- human-review output;
- review notes, assumptions, limitations, and next questions.

Blocked public positioning:

- live Slurm control;
- cluster command execution;
- drain, resume, reboot, or node modification;
- production deployment;
- verified reliability or savings improvement;
- customer validation;
- PMF or market proof;
- certification, endorsement, or compliance claim without written evidence.

### 3. Do not commit sensitive or customer-private material

Never commit:

- API keys, tokens, passwords, cookies, private keys, `.env` files, SSH material, or OAuth credentials;
- real customer data, facility logs, cluster exports, device identifiers, hostnames, tenant names, or internal network details;
- screenshots that show accounts, private emails, tokens, IP-sensitive infrastructure, dashboards, or incident evidence;
- private grant, investor, legal, military, hospital, or personal documents;
- unapproved connector exports or copied private chat/email/calendar content.

### 4. Use only safe demo data

Public demo data must be synthetic, public-domain/openly licensed, anonymized and approved, or explicitly non-sensitive and approved for public release.

Every public sample must include a note that it is sample/non-sensitive data and is not customer validation.

### 5. Review generated content before commit

AI-generated text, code, reports, issue bodies, and PR descriptions must be manually reviewed for unsupported claims, hallucinated partnerships or tests, accidental secrets, private data leakage, unsafe instructions, and any code that writes externally or implies live cluster control.

### 6. Keep public issues and PRs safe

Public issues and PRs must not contain secrets, customer data, incident evidence, exploit details, hostnames, IP-sensitive infrastructure details, or facility-specific logs. Security vulnerabilities must be reported through `SECURITY.md`, not through public issues.

## Public release and sharing gate

Before broad external sharing or major public announcement, complete:

1. Secret scan.
2. Customer/facility data scan.
3. Claim-boundary scan.
4. Workflow/log scan.
5. README review.
6. SECURITY review.
7. CONTRIBUTING review.
8. License decision review.
9. Final human approval.

## Incident response rule

If a secret, customer data, or sensitive artifact is found after publication:

1. Stop further sharing.
2. Rotate/revoke exposed credentials immediately.
3. Remove the content from the current branch.
4. Treat forks, clones, caches, and logs as potentially still exposed.
5. Document what was exposed, when, and what was revoked.
6. Do not discuss exploit details in public issues.

## Default rule

> Public sharing is blocked until the missing evidence or safety review is complete.

No Evidence = No Claim.  
No Data = No Conclusion.  
No Customer = No Validation.  
No Human Approval = No Public Release.
