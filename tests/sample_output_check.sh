#!/usr/bin/env bash
set -eu

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
SAMPLE_FILE="${ROOT_DIR}/examples/sinfo_sample.txt"
EXPECTED_FILE="${ROOT_DIR}/docs/evidence-packet-sample.md"
TEMP_DIR="$(mktemp -d)"
ACTUAL_FILE="${TEMP_DIR}/evidence_packet.md"
ALTERNATE_FILE="${TEMP_DIR}/evidence_packet_alternate.md"
STDOUT_FILE="${TEMP_DIR}/stdout.md"
trap 'rm -rf "${TEMP_DIR}"; rm -f "${ROOT_DIR}/dist/evidence_packet.md"; rmdir "${ROOT_DIR}/dist" 2>/dev/null || true' EXIT HUP INT TERM

bash "${ROOT_DIR}/scripts/trext-node-summary.sh" > "${STDOUT_FILE}"
cp "${ROOT_DIR}/dist/evidence_packet.md" "${ACTUAL_FILE}"
(
  cd "${ROOT_DIR}"
  bash scripts/trext-node-summary.sh >/dev/null
  cp dist/evidence_packet.md "${ALTERNATE_FILE}"
)

if ! cmp -s "${EXPECTED_FILE}" "${ACTUAL_FILE}"; then
  echo "FAIL: generated evidence packet differs from docs/evidence-packet-sample.md" >&2
  diff -u "${EXPECTED_FILE}" "${ACTUAL_FILE}" >&2 || true
  exit 1
fi

if ! cmp -s "${ACTUAL_FILE}" "${STDOUT_FILE}"; then
  echo "FAIL: stdout differs from the generated evidence packet" >&2
  diff -u "${ACTUAL_FILE}" "${STDOUT_FILE}" >&2 || true
  exit 1
fi

if ! cmp -s "${ACTUAL_FILE}" "${ALTERNATE_FILE}"; then
  echo "FAIL: output changes when the same input uses a different path form" >&2
  diff -u "${ACTUAL_FILE}" "${ALTERNATE_FILE}" >&2 || true
  exit 1
fi

for heading in \
  "## 1. Cluster snapshot summary" \
  "## 2. Suspected issue signals" \
  "## 3. Missing data" \
  "## 4. Review questions for operator" \
  "## 5. Limitations / no-claim boundary" \
  "## 6. Next action recommendation"
do
  if ! grep -Fq "${heading}" "${ACTUAL_FILE}"; then
    echo "FAIL: missing section: ${heading}" >&2
    exit 1
  fi
done

for expected in \
  "| Allocated | 2 |" \
  "| Idle | 4 |" \
  "| Drain | 1 |" \
  "| **Total** | **7** |" \
  "local sample replay only" \
  "Human review required"
do
  if ! grep -Fq "${expected}" "${ACTUAL_FILE}"; then
    echo "FAIL: missing expected output: ${expected}" >&2
    exit 1
  fi
done

echo "PASS: sample evidence packet is deterministic and contains the required sections."
