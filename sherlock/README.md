# Getting started with Sherlock

[Sherlock](https://www.sherlock.stanford.edu/) is a high-performance shared computing cluster for research at Stanford.

## Documentation

Documentation is available [here](https://www.sherlock.stanford.edu/docs/).

## Getting help

The official way to get support with Sherlock is to email srcc-support@stanford.edu.

The #sherlock-announce and #sherlock-users Slack channels (accessible from any Slack workspace within the Stanford University organization) are also great places to receive updates about the system and to get help from research computing staff or other users.

The SRCC also runs office hours over Zoom since the COVID-19 pandemic.
Please see [here](https://www.sherlock.stanford.edu/docs/#office-hours) for details.

## Getting an Account

To request an account on Sherlock, the sponsoring Stanford faculty member should email srcc-support@stanford.edu, specifying the names and SUNet IDs of their research team members needing an account.
Risa then needs to approve access to KIPAC resources.

## KIPAC Specific Sherlock Resources

KIPAC resources at Sherlock:
```
# sinfo $args -e -o "%.9R %.8m %.5D %.5c %N"
PARTITION   MEMORY NODES  CPUS NODELIST
    kipac   191000    28    24 sh02-03n[45-72]
    kipac   256000    84    32 sh03-03n[01-72],sh03-04n[01-12]
    kipac  1536000    16   256 sh04-11n[13-16],sh04-12n[13-16],sh04-13n[13-16],sh04-14n[13-16]
```
The last row above are the 16 recently acquired `CLASS:SH4_CSCALE` nodes with 1.5TB RAM and 256 CPU cores each.

KIPAC members have access to a number of other partition queues as well:
```
$ sh_part
 partition           || nodes         | CPU cores             | GPUs                 || job runtime     | mem/core        | per-node
 name         public ||   idle  total |   idle  total  queued |   idle  total queued || default maximum | default maximum |    cores   mem(GB)  gpus
-----------------------------------------------------------------------------------------------------------------------------------------------------
 normal*      yes    ||      1    211 |    747   5704   53812 |      0      0      0 ||      2h      7d |     6GB     8GB |    20-64   128-384     0
 bigmem       yes    ||      1     11 |    659    824     240 |      0      0      0 ||      2h      1d |     6GB    64GB |   24-256  384-4096     0
 gpu          yes    ||      0     33 |    250   1068    1925 |     25    136    220 ||      1h      2d |     8GB    32GB |    20-64  191-2048   3-8
 dev          yes    ||      0      4 |     69    104       1 |     62     64      0 ||      1h      2h |     6GB     8GB |    20-32   128-256  0-32
-----------------------------------------------------------------------------------------------------------------------------------------------------
 kipac        no     ||      0    128 |      3   7456       0 |      0      0      0 ||      2h      7d |     6GB     8GB |   24-256  191-1536     0
 hns          no     ||      0    144 |    477   5184    5008 |      4     12      2 ||      2h      7d |     6GB    26GB |   20-256  128-1536   0-4
-----------------------------------------------------------------------------------------------------------------------------------------------------
 owners       no     ||     11   1750 |   3838  63336   35309 |    514    872   2054 ||      2h      2d |     4GB    48GB |   20-256  128-4096   0-8
-----------------------------------------------------------------------------------------------------------------------------------------------------
```
The `kipac` queue will likely be your workhorse. You may find the `bigmem` and `gpu` nodes useful for memory intensive applications or applications requiring GPUs. The `owners` and `hns` queues may also be useful if other queues are particularly busy (note that `hns` now contains 4 GPUs). See the Sherlock documentation for more information.

KIPAC Oak storage is also accessible from Sherlock; please see the Oak documentation for more information.

## Transferring Data

Sherlock has Globus access through the data transfer node (DTN). See this [page](https://www.sherlock.stanford.edu/docs/storage/data-transfer/#transfer-protocols) for documentation. You can also use standard tools like `bbcp`, `scp` and `rsync`.

To get you started, here is an example using `scp`. Suppose your SUNet ID is `alice` and you want to transfer the file `data.zip` in your current directory to a directory named `project` in your home directory on Sherlock. The scp command to carry this out would be
```
scp data.zip alice@dtn.sherlock.stanford.edu:~/project/
```
Most importantly, you should not make (any, but particularly large) data transfers through the login endpoints. They are slower than through the DTN (data transfer node) and will disconnect after some timeout period. It is also more convenient to transfer through the DTN, as it (at the time of this writing) does not require duo mobile 2fa.
