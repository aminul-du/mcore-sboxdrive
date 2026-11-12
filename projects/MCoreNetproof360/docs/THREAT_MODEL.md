# STRIDE + SAII Security Threat Matrix

| Threat | STRIDE Category | Mitigation |
|---|---|---|
| Rogue Probe Injection | Spoofing | mTLS + SHA-256 evidence chain |
| Evidence Tampering | Tampering | PostgreSQL append-only triggers + hashes |
| Unauthorized Dashboard Access | Information Disclosure | Localhost-bound or Cloudflare Access tunnel auth |
| DDoS on API | Denial of Service | Cloudflare Zero Trust Tunnel + Rate Limiting |
| Compromised DB Credentials | Elevation of Privilege | `.env` isolation + local UNIX socket / vault |

## SAII 2050 Baseline
All AI inferences must be classified as `HYPOTHESIS` until verified by deterministic measurements and sealed by MCore Verification Plane attestations.
