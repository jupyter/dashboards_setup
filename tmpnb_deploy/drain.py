#!/usr/bin/python
# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

import requests
import sys

def main():
    print('Draining idle containers from the pool ...')
    sys.stdout.flush()
    resp = requests.delete('http://127.0.0.1:10000/api/pool')
    resp.raise_for_status()
    n = resp.json()['drained']
    print('Drained %d idle containers from the pool.' % n)
    print('The pool will refill after the --cull_period.')

if __name__ == '__main__':
    main()
