#!/usr/bin/env bash
set -eu

# TREXT local sample CLI skeleton.
# Sample-only and read-only: uses repository fixtures only.

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
OUT_DIR="${TREXT_OUT_DIR:-${ROOT_DIR}/reports/generated}"

usage() {
  cat <<'EOF'
Usage:
  bash scripts/trext.sh replay
  bash scripts/trext.sh report slurm-node-reasons
  bash scripts/trext.sh evidence-index
  bash scripts/trext.sh check-boundary

Mode:
  sample-only
  read-only
  human review required
EOF
}

ensure_out_dir() {
  mkdir -p "${OUT_DIR}"
}

hash_file() {
  file="$1"
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$file"
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$file"
  else
    echo "sha256-tool-missing  ${file}"
  fi
}

cmd_replay() {
  ensure_out_dir
  bash "${ROOT_DIR}/scripts/trext-node-summary.sh" "${ROOT_DIR}/examples/sinfo_sample.txt" > "${OUT_DIR}/node-status-summary.txt"
  cat "${OUT_DIR}/node-status-summary.txt"
  echo ""
  echo "Saved: reports/generated/node-status-summary.txt"
}

cmd_report_slurm_node_reasons() {
  ensure_out_dir
  sample="${ROOT_DIR}/examples/sinfo_R_sample.txt"
  output="${OUT_DIR}/slurm-node-reasons-report.md"

  if [ ! -f "$sample" ]; then
    echo "Error: sample file not found: ${sample}" >&2
    exit 1
  fi

  {
    echo "# Slurm Problem Node Reason Evidence Report"
    echo ""
    echo "Data source: sample sinfo -R style fixture"
    echo "Mode: read-only"
    echo "Human review: required"
    echo ""
    echo "## Observed reason rows"
    echo ""
    echo "| Reason | User | Timestamp | Node list |"
    echo "|---|---|---|---|"
    awk 'NR > 1 && NF >= 4 { print "| " $1 " | " $2 " | " $3 " | " $4 " |" }' "$sample"
    echo ""
    echo "## Review questions"
    echo ""
    echo "1. Is this reason still active in the live scheduler?"
    echo "2. Is there a related maintenance window or known software change?"
    echo "3. Which user jobs were affected before this node reason appeared?"
    echo "4. Is the node reason repeated across multiple nodes or isolated?"
    echo "5. Which next action requires human approval?"
    echo ""
    echo "## Boundary"
    echo ""
    echo "- This report lists evidence candidates only."
    echo "- This report does not make a final diagnosis."
    echo "- This report does not recommend automated action."
    echo "- This report does not claim savings, reliability improvement, or production readiness."
  } > "$output"

  cat "$output"
  echo ""
  echo "Saved: reports/generated/slurm-node-reasons-report.md"
}

cmd_evidence_index() {
  ensure_out_dir
  output="${OUT_DIR}/evidence-index.sha256"
  : > "$output"

  for dir in examples docs reports; do
    if [ -d "${ROOT_DIR}/${dir}" ]; then
      find "${ROOT_DIR}/${dir}" -type f | sort | while IFS= read -r file; do
        case "$file" in
          *"/reports/generated/evidence-index.sha256") continue ;;
        esac
        hash_file "$file" | sed "s#${ROOT_DIR}/##" >> "$output"
      done
    fi
  done

  cat "$output"
  echo ""
  echo "Saved: reports/generated/evidence-index.sha256"
}

cmd_check_boundary() {
  scan_paths="${ROOT_DIR}/README.md ${ROOT_DIR}/docs ${ROOT_DIR}/examples"
  forbidden='TREXT solves GPU operations|TREXT guarantees cost savings|TREXT performs real-time control|customer validation is complete|market is proven|장애 원인을 판정함|운영자 결정을 대체함|실시간 제어 가능|자동 최적화 가능|시장이 입증됨|고객이 원함'

  if grep -R -n -E "$forbidden" $scan_paths >/tmp/trext-boundary-findings.txt 2>/dev/null; then
    echo "Boundary check failed. Review these claim-risk lines:" >&2
    cat /tmp/trext-boundary-findings.txt >&2
    exit 1
  fi

  echo "Boundary check passed. No forbidden product-claim phrases found in README/docs/examples."
}

main() {
  if [ "$#" -eq 0 ]; then
    usage
    exit 0
  fi

  case "$1" in
    -h|--help)
      usage
      ;;
    replay)
      cmd_replay
      ;;
    report)
      if [ "${2:-}" = "slurm-node-reasons" ]; then
        cmd_report_slurm_node_reasons
      else
        echo "Error: unknown report command: ${2:-}" >&2
        usage >&2
        exit 1
      fi
      ;;
    evidence-index)
      cmd_evidence_index
      ;;
    check-boundary)
      cmd_check_boundary
      ;;
    *)
      echo "Error: unknown command: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
}

main "$@"
