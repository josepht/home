#!/usr/bin/env python

import os
import yaml

data = None
with open(os.path.expanduser('~/.juju/environments.yaml'), 'r') as fp:
    data = yaml.load(fp)

envs = data.get('environments')
print(" ".join(envs.keys()))

