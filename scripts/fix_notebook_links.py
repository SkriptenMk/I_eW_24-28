#!/usr/bin/env python3
"""Fix notebook links in generated HTML under docs/.

This script scans HTML files under ./docs for anchors pointing to .html files
and, when a corresponding .ipynb exists in the docs tree, replaces the href
with a relative path to that .ipynb. Useful after running the copy script so
that links in the rendered HTML download the notebook file instead of linking
to an HTML page.

Usage:
  python3 scripts/fix_notebook_links.py [--dry-run]

The script prints a summary of fixes. In --dry-run mode it only shows what it
would change.
"""
import argparse
import os
import re
from pathlib import Path


def find_ipynbs(docs_root: Path):
    ipynbs = {}
    for p in docs_root.rglob('*.ipynb'):
        key = p.stem  # filename without extension
        ipynbs.setdefault(key, []).append(p)
    return ipynbs


A_TAG_RE = re.compile(r'''<a\s+[^>]*href=("|')([^"']+?\.html)\1[^>]*>(.*?)</a>''', re.IGNORECASE | re.DOTALL)


def _text_snippet(inner_html: str) -> str:
    # crude strip of tags to get visible text
    return re.sub(r'<[^>]+>', '', inner_html).strip()


def fix_file(html_path: Path, ipynbs_map, docs_root: Path, dry_run: bool, force: bool = False):
    text = html_path.read_text(encoding='utf8')
    changed = False
    replacements = []

    def handle_match(m):
        full = m.group(0)
        quote = m.group(1)
        href = m.group(2)
        inner = m.group(3)
        inner_text = _text_snippet(inner)
        name = Path(href).stem

        candidates = ipynbs_map.get(name)
        if not candidates:
            return full

        # determine the file that the href points to on disk (if relative)
        target_html_path = (html_path.parent / href).resolve()
        html_exists = target_html_path.exists()

        # If HTML exists and user didn't force, only replace if anchor text suggests it's a notebook
        anchor_says_notebook = ('.ipynb' in inner_text) or ('jupyter' in inner_text.lower()) or ('notebook' in inner_text.lower())
        if html_exists and not (anchor_says_notebook or force):
            # safe: don't replace links to existing HTML pages
            return full

        # pick candidate: prefer same relative folder if possible
        if len(candidates) == 1:
            target = candidates[0]
        else:
            sel = None
            for c in candidates:
                if c.parent.name in href or c.parent.name in html_path.parts:
                    sel = c
                    break
            target = sel or candidates[0]

        rel = os.path.relpath(target, start=html_path.parent)
        rel = Path(rel).as_posix()
        replacements.append((href, rel, str(html_exists), inner_text))
        nonlocal changed
        changed = True
        # return the anchor with href replaced but keep other attributes and inner HTML
        return full.replace(href, rel)

    new_text = A_TAG_RE.sub(handle_match, text)

    if dry_run:
        if replacements:
            print(f'[DRY] {html_path} -> replacements:')
            for old, new, existed, inner_text in replacements:
                note = 'EXISTED' if existed == 'True' else 'missing-html'
                print(f'    {old}  ->  {new}   ({note})  anchor-text="{inner_text[:80]}"')
        return changed

    if changed:
        html_path.write_text(new_text, encoding='utf8')
        print(f'Updated {html_path} ({len(replacements)} replacements)')
    return changed


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--docs', default='docs', help='Docs root directory')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--force', action='store_true', help='Replace even when target HTML exists if heuristics match')
    args = parser.parse_args()

    docs_root = Path(args.docs)
    if not docs_root.exists():
        print(f'Error: docs root {docs_root} does not exist')
        raise SystemExit(2)

    ipynbs = find_ipynbs(docs_root)
    if not ipynbs:
        print('No .ipynb files found under docs/ — nothing to do')
        return

    total = 0
    touched = 0
    for html in docs_root.rglob('*.html'):
        total += 1
        if fix_file(html, ipynbs, docs_root, args.dry_run, force=args.force):
            touched += 1

    print(f'Done. Scanned {total} HTML files, updated {touched} files.')


if __name__ == '__main__':
    main()
