#!/usr/bin/env python3
"""
Copy .ipynb files from the repository into the site output directory (docs/) while
preserving relative paths.

Usage:
  python3 scripts/copy_notebooks_to_docs.py [--dry-run] [--src SRC_DIR] [--dst DST_DIR]

Defaults:
  SRC_DIR = '.' (searches recursively)
  DST_DIR = 'docs'

Behavior:
  - Preserves directory structure under DST_DIR (e.g., files/lektionen/.../foo.ipynb -> docs/files/lektionen/.../foo.ipynb)
  - Skips copying if destination exists and content is identical (byte-wise)
  - Supports --dry-run to print actions without modifying files
"""

from __future__ import annotations
import argparse
import hashlib
import os
import shutil
from pathlib import Path
from typing import Iterable


def iter_files_with_ext(root: Path, exts: set[str]) -> Iterable[Path]:
    """Yield files under root whose suffix (without dot) is in exts.

    exts should be lower-case strings without the leading dot, e.g. {'ipynb','txt'}.
    """
    for p in root.rglob('*'):
        if not p.is_file():
            continue
        # skip anything already under docs to avoid recursive copies
        if 'docs' in p.parts:
            continue
        suf = p.suffix.lower().lstrip('.')
        if suf in exts:
            yield p


def file_hash(path: Path) -> str:
    h = hashlib.sha256()
    with path.open('rb') as f:
        while True:
            chunk = f.read(8192)
            if not chunk:
                break
            h.update(chunk)
    return h.hexdigest()


def copy_notebooks(src_root: Path, dst_root: Path, dry_run: bool = False, exts: set[str] = None) -> int:
    copied = 0
    src_root = src_root.resolve()
    dst_root = dst_root.resolve()
    if exts is None:
        exts = {'ipynb'}
    for src in iter_files_with_ext(src_root, exts):
        rel = src.relative_to(src_root)
        dst = dst_root.joinpath(rel)
        dst_parent = dst.parent
        if not dry_run:
            dst_parent.mkdir(parents=True, exist_ok=True)
        # if dst exists and identical, skip
        if dst.exists():
            if file_hash(src) == file_hash(dst):
                print(f"SKIP (identical): {rel}")
                continue
            else:
                print(f"UPDATE: {rel}")
        else:
            print(f"COPY: {rel}")
        if not dry_run:
            shutil.copy2(src, dst)
            copied += 1
    print(f"\nDone. Files copied/updated: {copied}")
    return copied


def main():
    parser = argparse.ArgumentParser(description="Copy files (notebooks and assets) into docs/ for site distribution")
    parser.add_argument('--dry-run', action='store_true', help='Show what would be copied without changing files')
    parser.add_argument('--src', default='.', help='Source root to search for files (default: .)')
    parser.add_argument('--dst', default='docs', help='Destination root to copy files into (default: docs)')
    parser.add_argument('--ext', default='ipynb', help='Comma-separated list of file extensions to copy (default: ipynb). Example: --ext ipynb,txt,pdf')
    args = parser.parse_args()

    src_root = Path(args.src)
    dst_root = Path(args.dst)

    if not src_root.exists():
        print(f"Source root does not exist: {src_root}")
        raise SystemExit(2)

    # parse extensions list
    exts = set([e.strip().lower().lstrip('.') for e in args.ext.split(',') if e.strip()])
    print(f"Searching for files with extensions {exts} under: {src_root}")
    print(f"Destination root: {dst_root}")
    if args.dry_run:
        print("DRY RUN: no files will be copied")

    copy_notebooks(src_root, dst_root, dry_run=args.dry_run, exts=exts)


if __name__ == '__main__':
    main()
