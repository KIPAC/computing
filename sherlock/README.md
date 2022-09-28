Getting Started
===============

[Sherlock](https://www.sherlock.stanford.edu/) is a high-performance shared computing cluster for research at Stanford.

Documentation
-------------

Documentation is available [here](https://www.sherlock.stanford.edu/docs/).

Getting help
------------

The official way to get support with Sherlock is to email srcc-support@stanford.edu.

The #sherlock-announce and #sherlock-users Slack channels (accessible from any Slack workspace within the Stanford University organization) are also great places to receive updates about the system and to get help from research computing staff or other users.

The SRCC also runs office hours over Zoom since the COVID-19 pandemic.
Please see [here](https://www.sherlock.stanford.edu/docs/#office-hours) for details.

KIPAC Specific Sherlock-isms
----------------------------

KIPAC resources at Sherlock:
```
$ sinfo -p kipac -s
PARTITION AVAIL  TIMELIMIT   NODES(A/I/O/T) NODELIST
kipac        up 7-00:00:00      112/0/0/112 sh02-03n[45-72],sh03-03n[01-72],sh03-04n[01-12]
```

KIPAC members access to a number of other partition queues as well:
```
$ sh_part
     QUEUE STA   FREE  TOTAL RESORC  OTHER   FREE  TOTAL || DEFMEM MAXMEM    DEFAULT    MAXIMUM    CORES       NODE    QOS  GRES
 PARTITION TUS  CORES  CORES PENDNG PENDNG  NODES  NODES || GB/CPU GB/CPU   JOB-TIME   JOB-TIME    /NODE     MEM-GB   NAME (NODE-COUNT)
    normal  *q     61   4032  18738   2065      0    154 ||      6      8     2 hour     7 days    20-32    128-256      - -
    bigmem   q    170    408      0      0      0      5 ||      8     64     2 hour     1 days   32-128   512-4096 bigmem -
       dev   q     32     40      0      0      1      2 ||      6      6     1 hour     2 hour       20        128    dev -
       gpu   q    287    748    165    100      0     26 ||      7     12     1 hour     2 days    20-32    191-256    gpu gpu:4(S:0-1)(20),gpu:4(S:0)(6)
       hns   g   1634   3216   1944    491      0     95 ||      6     25     2 hour     7 days   20-128   128-1024  owner -
     kipac   g     74   3360      0      0      0    112 ||      7      8     2 hour     7 days    24-32    191-256  owner -
    owners  qg   5785  38172  13595   6927     20   1254 ||      4     48     2 hour     2 days   20-128   128-4096 owners gpu:4(S:0-1)(67),gpu:8(S:0-1)(13),gpu:4(S:0)(5),gpu:4(S:0-3)(6),gpu:8(S:0-3)(8),gpu:4(2)

```

Individual PI groups may have additional resources.

KIPAC Oak storage is also accessible from Sherlock; please see the Oak documentation for more information.

Transferring Data
-----------------

Sherlock has Globus access through the data transfer node (DTN). See this [page](https://www.sherlock.stanford.edu/docs/storage/data-transfer/#transfer-protocols) for documentation. You can also use standard tools like `bbcp`, `scp` and `rsync`.
