#!/usr/bin/env python
"""
This script downloads the known_hosts file for SLAC computing cluster, 
and updates the local ~/.ssh/known_hosts file.

License: CC0 1.0 Universal https://creativecommons.org/publicdomain/zero/1.0/
Yao-Yuan Mao (2015)
"""

import os
from urllib import urlopen

if __name__ == '__main__':
    os.chdir(os.getenv('HOME') + '/.ssh')
    my_hosts = []
    if os.path.isfile('known_hosts'):
        with open('known_hosts', 'r') as f:
            for l in f:
                if l[0] != '#' and l[0] != '\n' and 'slac.stanford.edu' not in l:
                    my_hosts.append(l)
        os.rename('known_hosts', 'known_hosts.bak')

    slac_hosts = urlopen('ftp://ftp.slac.stanford.edu/admin/known_hosts').read()

    with open('known_hosts', 'w') as f:
        f.write(slac_hosts)
        if len(my_hosts):
            f.write('#below are non-slac hosts\n')
            f.write(''.join(my_hosts))

