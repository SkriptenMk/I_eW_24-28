#!/usr/bin/env python3
"""Clear outputs and execution_count from Jupyter notebooks.
Usage: python3 scripts/clear_notebook_outputs.py path1.ipynb [path2.ipynb ...]
"""
import sys
import json

if len(sys.argv) < 2:
    print("Usage: clear_notebook_outputs.py notebook.ipynb [...]")
    sys.exit(2)

for path in sys.argv[1:]:
    print(f"Processing {path}")
    with open(path, 'r', encoding='utf-8') as f:
        nb = json.load(f)

    changed = False
    for cell in nb.get('cells', []):
        if cell.get('cell_type') == 'code':
            if cell.get('outputs'):
                if len(cell['outputs']) > 0:
                    cell['outputs'] = []
                    changed = True
            if 'execution_count' in cell and cell['execution_count'] is not None:
                cell['execution_count'] = None
                changed = True

    if changed:
        with open(path, 'w', encoding='utf-8') as f:
            json.dump(nb, f, ensure_ascii=False, indent=1)
        print(f"Cleared outputs in {path}")
    else:
        print(f"No outputs to clear in {path}")
