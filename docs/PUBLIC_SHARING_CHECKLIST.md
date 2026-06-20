# Public Sharing Checklist

Use this checklist before broad external sharing or major public announcement of this repository.

Public sharing is blocked until every required gate is complete and a human maintainer approves the release.

## Required gate

- [ ] `docs/PUBLIC_REPOSITORY_OPERATOR_GUIDE.md` reviewed
- [ ] README safe wording checked
- [ ] `SECURITY.md` present and private reporting route checked
- [ ] `CONTRIBUTING.md` present and contribution rules checked
- [ ] Pull request template present and safety checklist checked
- [ ] No secrets, tokens, passwords, cookies, private keys, `.env`, SSH material, or OAuth credentials
- [ ] No customer data
- [ ] No facility-private logs, Slurm exports from real clusters, device identifiers, hostnames, internal network details, or private screenshots
- [ ] No production claim
- [ ] No live Slurm-control claim
- [ ] No drain/resume/reboot/node-modification claim
- [ ] No guaranteed reliability, cost, energy, or operations-improvement claim
- [ ] No customer validation claim
- [ ] No PMF, market proof, or investment readiness claim
- [ ] No certification, endorsement, or compliance claim without committed evidence
- [ ] REVIEW_NEEDED items checked
- [ ] Demo outputs are sample, synthetic, public, anonymized, or explicitly approved non-sensitive data
- [ ] GitHub Actions logs and artifacts checked for sensitive paths, outputs, or tokens
- [ ] Public issues and PRs checked for sensitive details
- [x] License decision explicitly made by maintainer; Apache-2.0 LICENSE added in commit c591fa0, CI passed
- [ ] Final human approval recorded before broad public sharing

## Visibility warning

This repository is already public. Assume every committed file, issue, pull request, workflow log, and screenshot may be copied, forked, cached, or quoted.

## Stop condition

If any item above is uncertain, public sharing is blocked.

Default decision:

> No Human Approval = No Public Release.
