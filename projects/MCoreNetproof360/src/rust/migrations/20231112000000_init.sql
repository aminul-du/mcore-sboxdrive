CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE IF NOT EXISTS measurements (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    service_id VARCHAR(255) NOT NULL,
    zone VARCHAR(50) NOT NULL,
    port INT NOT NULL,
    critical BOOLEAN NOT NULL,
    ok BOOLEAN NOT NULL,
    tcp_ok BOOLEAN NOT NULL,
    http_status VARCHAR(50) NOT NULL,
    rtt_ms BIGINT NOT NULL,
    evidence_sha256 VARCHAR(64) NOT NULL,
    raw_evidence JSONB NOT NULL,
    executed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_measurements_service ON measurements(service_id);
CREATE INDEX IF NOT EXISTS idx_measurements_time ON measurements(executed_at DESC);
