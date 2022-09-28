Getting Started
===============

The [SDF](https://sdf.slac.stanford.edu/public/doc/#/) is a computing cluster for research at SLAC

Documentation
-------------

Documentation is available [here](https://sdf.slac.stanford.edu/public/doc/#/).

Getting help
------------

For general help or reporting problems, please email s3df-help@slac.stanford.edu.

For general discussion, please see the #comp-sdf channel on the SLAC Slack workspace.


KIPAC Specific Resources
----------------------------

KIPAC has a total of 2048 CPUs and 10TB of RAM on the SDF across a number of nodes:
```
$ sinfo -p kipac -s
PARTITION AVAIL  TIMELIMIT   NODES(A/I/O/T) NODELIST
kipac        up 10-00:00:0      108/0/6/114 rome[0001-0004,0011-0014,0021-0024,0031-0034,0041-0044,0051-0054,0061-0064,0071-0074,0081-0084,0091-0094,0101-0104,0111-0114,0121-0124,0131-0134,0141-0144,0151-0154,0161-0164,0171-0174,0181-0184,0191-0194,0201-0204,0211-0214,0221-0224,0231-0234,0241-0244,0251-0254,0261-0264,0271-0274,0321-0322]
```

Note About S3DF
---------------

Please note that the SLAC systems are upgrading from SDF to [S3DF](https://s3df.slac.stanford.edu/public/doc/#/); for now, KIPAC owns resources on SDF.
