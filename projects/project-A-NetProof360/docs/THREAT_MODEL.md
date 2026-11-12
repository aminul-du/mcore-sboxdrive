# NetProof360 Threat Model
### Attack Surface & SAII Protective Invariants

---

## 1. Threat Taxonomy (STRIDE + SAII Extensions)

| ID | Threat Category | Attack Vector | NetProof360 Mitigation | Impact Level |
|---|---|---|---|---|
| **TH-01** | **Spoofing** | Rogue node masquerading as an authorized agent Gateway hop | Hardware-bound TLS fingerprinting & HMAC node attestation | High |
| **TH-02** | **Tampering** | In-transit payload mutation between microservices | End-to-end cryptographic packet hash chain (`SHA-256`) | Critical |
| **TH-03** | **Repudiation** | Agent denying route transmission or packet drop | Unalterable timestamped `evidence.json` telemetry logs | Medium |
| **TH-04** | **Info Disclosure** | Unencrypted telemetry sniffing across local virtual bridges | Mutual TLS (mTLS) with pinned client certificates | High |
| **TH-05** | **Denial of Service** | Synthetic probe flooding / resource exhaustion | Ingress rate limiting and probe kernel cgroup isolation | High |
| **TH-06** | **Elevation of Privilege** | Routing bypass injecting unauthorized MCP server calls | Strict Zero-Trust routing tables enforcing DENY-ALL | Critical |

---

## 2. Cross-Agent Route Poisoning Prevention
In distributed agent meshes, memory poisoning can be coupled with network routing distortion (e.g., redirecting an agent to an adversarial mock MCP server).
NetProof360 prevents route poisoning by:
1. Validating canonical MCP route addresses against `mcore-state.yaml`.
2. Verifying TLS certificates against local pinned root CAs.
3. Rejecting any route change that lacks an attestation signed by `MCORE-FDR-AIS-001`.
