# DeepSeek & External Web AI Research Ingest
### SBoxDrive Unified Knowledge Intake Model

---

## 1. Context & Purpose
This document establishes the ingestion format and catalog for research data, network heuristics, and architecture specifications collected from external Web AIs (e.g., DeepSeek, ChatGPT, Gemini, Claude).

In accordance with MCore SBoxDrive principles:
- External AI outputs are treated as **untrusted passive intelligence** until validated.
- All imported files, code snippets, and research notes must be logged with their origin, purpose, and verification status.
- Once validated by AIS and NetProof360 tests, artifacts graduate into canonical project directories.

---

## 2. Ingested AI Artifact Inventory

| Ingest ID | Source AI | Ingestion Date | Target Component | Purpose & Description | Validation Status |
|---|---|---|---|---|---|
| **ING-DS-01** | DeepSeek-V3 | 2026-11-12 | NetProof360 Core | Formal routing verification algorithms using graph reachability matrices | Validated & Implemented |
| **ING-DS-02** | DeepSeek-R1 | 2026-11-12 | Threat Model | Reasoning trace on BGP route poisoning vs local bridge tampering | Integrated into THREAT_MODEL.md |
| **ING-DS-03** | DeepSeek-Coder | 2026-11-13 | Telemetry Collector | Lightweight non-blocking Python socket probe with nanosecond timestamping | Implemented in collector.py |
| **ING-DS-04** | DeepSeek-V3 | 2026-11-13 | Verification Engine | Merkle-tree based route state hashing for zero-trust proof emission | Implemented in verifier.py |

---

## 3. Standardization Template for Future Ingests
When adding new research outputs from DeepSeek or other Web AIs:
1. Save raw research markdown in `projects/<project-name>/docs/ingest/`.
2. Add a record to the project inventory table above.
3. Reference the artifacts in the canonical root `MANIFEST.md` via `scripts/generate-manifest.sh`.
4. Ensure no credentials, API keys, or proprietary internal tokens are stored in the ingest logs.
