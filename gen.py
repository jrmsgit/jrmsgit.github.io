#!/usr/bin/env python3

import os
import sys

for dirname, dirs, files in os.walk('recetas'):
	with open('%s/index.md' % dirname, 'w') as fh:
		for fn in sorted(files):
			if fn == 'index.md':
				continue
			fn = fn[:-3]
			name = fn.replace('_', ' ').title()
			link = './%s' % fn
			print('* [%s](%s)' % (name, link), file = fh)

sys.exit(0)
