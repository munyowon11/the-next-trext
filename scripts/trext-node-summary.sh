#!/usr/bin/env bash
set -eu

# Local sample replay only. This script reads a text fixture and writes Markdown.
# It intentionally contains no Slurm, SSH, network, or cluster-control calls.

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"

SAMPLE_FILE="${ROOT_DIR}/examples/sinfo_sample.txt"

OUTPUT_FILE="${ROOT_DIR}/dist/evidence_packet.md"



usage() {

  cat <<'EOF'

Usage:

  bash scripts/trext-node-summary.sh



Defaults:

  sample-file: examples/sinfo_sample.txt (fixed Stage 1 synthetic fixture; custom input is future private validation only)

  output-file: dist/evidence_packet.md (fixed Stage 1 sample output)



This is a sample-only, read-only replay. Human review is required.

EOF

}



if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then

  usage

  exit 0

fi



if [ "$#" -ne 0 ]; then

  echo "Error: Stage 1 sample-mode does not accept custom input or output paths." >&2

  echo "Use the fixed synthetic fixture: examples/sinfo_sample.txt" >&2

  echo "Approved/anonymized real exports belong to a future private validation stage, not this public sample script." >&2

  exit 2

fi



if [ ! -f "${SAMPLE_FILE}" ]; then
  echo "Error: sample file not found: ${SAMPLE_FILE}" >&2
  exit 1
fi

SAMPLE_DIR="$(CDPATH= cd -- "$(dirname -- "${SAMPLE_FILE}")" && pwd)"
SAMPLE_FILE="${SAMPLE_DIR}/$(basename -- "${SAMPLE_FILE}")"

case "${SAMPLE_FILE}" in
  "${ROOT_DIR}/"*) SOURCE_LABEL="${SAMPLE_FILE#"${ROOT_DIR}/"}" ;;
  *) SOURCE_LABEL="${SAMPLE_FILE}" ;;
esac

mkdir -p "$(dirname -- "${OUTPUT_FILE}")"
TEMP_FILE="$(mktemp "${OUTPUT_FILE}.tmp.XXXXXX")"
trap 'rm -f "${TEMP_FILE}"' EXIT HUP INT TERM

awk -v source="${SOURCE_LABEL}" '
BEGIN {
  total = idle = alloc = drain = down = mix = other = 0
  data_rows = 0
}

NR == 1 {
  if ($1 != "PARTITION" || $4 != "NODES" || $5 != "STATE") {
    print "Error: expected a sinfo-like header" > "/dev/stderr"
    exit 2
  }
  next
}

NF >= 6 && $4 ~ /^[0-9]+$/ {
  partition = $1
  nodes = $4 + 0
  state = tolower($5)
  nodelist = $6

  data_rows++
  total += nodes
  partitions[partition] = 1

  if (state == "idle") idle += nodes
  else if (state == "alloc" || state == "allocated") alloc += nodes
  else if (state == "drain" || state == "drng" || state == "drained") {
    drain += nodes
    drain_lists = append_list(drain_lists, nodelist)
  } else if (state == "down") {
    down += nodes
    down_lists = append_list(down_lists, nodelist)
  } else if (state == "mix" || state == "mixed") mix += nodes
  else {
    other += nodes
    other_states[state] += nodes
  }
}

function append_list(existing, value) {
  return existing == "" ? value : existing ", " value
}

function plural(value, singular, plural_value) {
  return value == 1 ? singular : plural_value
}

END {
  if (data_rows == 0) {
    print "Error: sample file contains no node rows" > "/dev/stderr"
    exit 3
  }

  partition_count = 0
  for (partition in partitions) partition_count++

    print "> **SAMPLE OUTPUT - NOT REAL CLUSTER DATA**"
  print "> This file is generated from a local synthetic fixture (`examples/sinfo_sample.txt`)."
  print "> It does not represent a real cluster, real nodes, or real operational state."
  print "> No live Slurm integration. No action taken. Human review required before any operation."
  print ""
  print "# TREXT Sample Evidence Packet"
  print ""
  print "- Data source: `" source "`"
  print "- Mode: local sample replay only"
  print "- Generated deterministically from the supplied fixture"
  print "- Human review required"
  print ""
  print "## 1. Cluster snapshot summary"
  print ""
  print "The sample contains **" total " nodes** across **" partition_count " " plural(partition_count, "partition", "partitions") "**."
  print ""
  print "| Node state | Count |"
  print "|---|---:|"
  print "| Allocated | " alloc " |"
  print "| Idle | " idle " |"
  print "| Mixed | " mix " |"
  print "| Drain | " drain " |"
  print "| Down | " down " |"
  print "| Other / unrecognized | " other " |"
  print "| **Total** | **" total "** |"
  print ""
  print "## 2. Suspected issue signals"
  print ""

  signal_count = 0
  if (drain > 0) {
    print "- **Drain state observed:** " drain " " plural(drain, "node is", "nodes are") " marked `drain` (" drain_lists "). This is a review signal, not a root-cause finding."
    signal_count++
  }
  if (down > 0) {
    print "- **Down state observed:** " down " " plural(down, "node is", "nodes are") " marked `down` (" down_lists "). Operator context is required."
    signal_count++
  }
  if (other > 0) {
    print "- **Unrecognized state data:** " other " node entries use states outside this MVP'\''s known state set."
    signal_count++
  }
  if (signal_count == 0) {
    print "- No drain, down, or unrecognized node states appear in this sample."
  }
  print "- Allocated and idle counts are snapshot observations only; they do not establish utilization efficiency or waste."
  print ""
  print "## 3. Missing data"
  print ""
  print "This input does not include:"
  print ""
  print "- snapshot capture time"
  print "- drain or down reason"
  print "- node state transition time or prior state"
  print "- job queue, pending reason, or job-to-node context"
  print "- maintenance window or change history"
  print "- hardware, network, storage, and scheduler health evidence"
  print ""
  print "## 4. Review questions for operator"
  print ""
  print "1. Is the observed node state still current, or was it transient?"
  print "2. What reason and timestamp are associated with each drain or down node?"
  print "3. Was there a maintenance event or configuration change near the state transition?"
  print "4. Are queued or running jobs affected?"
  print "5. What additional local evidence is safe and useful to add to a sanitized replay fixture?"
  print ""
  print "## 5. Limitations / no-claim boundary"
  print ""
  print "- This packet is generated from a local sample file only."
  print "- It does not connect to Slurm, use SSH, send control commands, or transmit cluster data."
  print "- It does not determine root cause or authorize operational action."
  print "- It does not claim guaranteed savings, autonomous optimization, production readiness, or customer validation."
  print "- The sample may omit conditions present in a real cluster. Human review is required."
  print ""
  print "## 6. Next action recommendation"
  print ""
  if (drain > 0 || down > 0) {
    print "For Stage 1 public sample-mode, record missing reason/timestamp evidence as operator review questions only. Approved/anonymized real exports belong to a future private validation stage. Do not take cluster action based on this sample packet."
  } else {
    print "For Stage 1 public sample-mode, keep this as a fixed synthetic fixture replay and document additional evidence needs separately. Do not take cluster action based on this sample packet."
  }
}
' "${SAMPLE_FILE}" > "${TEMP_FILE}"

chmod 0644 "${TEMP_FILE}"
mv "${TEMP_FILE}" "${OUTPUT_FILE}"
trap - EXIT HUP INT TERM

cat "${OUTPUT_FILE}"
echo "Created: ${OUTPUT_FILE}" >&2
