#!/usr/bin/env python3
"""
NetProof360 Manifest Hook for MCore SBoxDrive
MCORE AIS/BOX-1.0 Sovereign Autonomous Intelligence Infrastructure
"""

import os
import hashlib
import json

def get_project_artifacts():
    base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    artifacts = []

    for root, dirs, files in os.walk(base_dir):
        # Exclude git, caches, and evidence snapshots from git tracking
        if "__pycache__" in root or ".git" in root:
            continue
        for f in files:
            path = os.path.join(root, f)
            rel_path = os.path.relpath(path, base_dir)
            size = os.path.getsize(path)
            with open(path, "rb") as fp:
                file_hash = hashlib.sha256(fp.read()).hexdigest()
            artifacts.append({
                "path": os.path.join("projects", "project-A-NetProof360", rel_path),
                "size_bytes": size,
                "sha256": file_hash
            })
    return artifacts

if __name__ == "__main__":
    arts = get_project_artifacts()
    print(f"[NetProof360 Manifest Hook] Discovered {len(arts)} project artifacts.")
    print(json.dumps(arts[:3], indent=2))
