#!/usr/bin/env python3

import os
import sys

for src, dirs, _ in os.walk('.'):
  if src != '.':
    break
  with open('index.md', 'w') as index:
    print('# Index\n', file = index)
    for dn in sorted(dirs):
      if dn.startswith('.'):
        continue
      dncount = 0
      for dirname, dirs, files in os.walk(dn):
        with open('%s/index.md' % dirname, 'w') as fh:
          print('# %s\n' % dirname.title(), file = fh)
          for fn in sorted(files):
            if fn.startswith('.'):
              continue
            if not fn.endswith('.md'):
              continue
            if fn == 'index.md':
              continue
            fn = fn[:-3]
            name = fn.replace('_', ' ').title()
            print('* [%s](./%s)' % (name, fn), file = fh)
            dncount += 1
        if dncount == 0:
          os.unlink('%s/index.md' % dirname)
      if dncount > 0:
        print('## [%s](./%s)\n' % (dn.title(), dn), file = index)

sys.exit(0)
