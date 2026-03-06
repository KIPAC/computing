# Getting started with S3DF

The [SLAC Shared Science Data Facility (S3DF)](https://s3df.slac.stanford.edu) is a compute, storage and network facility supporting SLAC science.

## Documentation

Documentation is available [here](https://s3df.slac.stanford.edu/public/doc/#/).

## Getting help

For getting help and reporting problems email s3df-help@slac.stanford.edu.

For general discussion see the #comp-sdf channel on the SLAC Slack workspace.

## Getting an Account

If you are a SLAC employee or affiliated researcher (i.e. with KIPAC) with a SLAC computing account, you are eligible for an S3DF account. To enable your S3DF account, log into [coact](https://coact.slac.stanford.edu/) using your SLAC computing credentials and follow the instructions to request membership in the KIPAC S3DF facility. 

(Note that S3DF is presently in a transition from Unix to SSO/ActiveDirectory authentication for all S3DF web and SSH bastions anticipated to be complete in the Fall of 2025. Unix account passwords will not work with S3DF services after the transition. If you currently only have a Unix account you can provision your SSO/ActiveDirectory account via a self-service portal at [https://ad-account.slac.stanford.edu](https://ad-account.slac.stanford.edu) using your Unix account and follow the directions to create your SSO/ActiveDirectory account.)

## KIPAC Specific Resources

KIPAC members have access to five Slurm partitions: `ada`, `ampere`, `hopper`, `milano`, and `roma`.

Current partition hardware summary:

| Partition | Nodes | KIPAC nodes | CPUs | Memory / node | GPUs |
|---|---:|---:|---:|---:|---:|
| `ada` | 19 | 0 | 96 | 702 GB | 10 x L40S |
| `ampere` | 42 | 0 | 128 | 952 GB | 4 x A100 |
| `hopper` | 3 | 0 | 256 | 1344 GB | 4 x H200 |
| `milano` (480 GB) | 268 | 0 | 128 | 480 GB | none |
| `milano` (1920 GB) | 4 | 4 | 128 | 1920 GB | none |
| `roma` | 130 | 13 | 128 | 480 GB | none |

The 4 high-memory Milano nodes are `sdfmilan269-272` (1920 GB each).

## S3DF data storage for KIPAC

Directories in /sdf/data/kipac/u are intended for the exclusive use of each corresponding user. Please only write to the directory that corresponds to your username, and keep all files and subdirectories group-readable so we can track usage within the group. The current default limit is 1TB for each user. This limit may increase in the future as we increase capacity and/or free up space. If you need more than the current limit, please contact Marcelo Alvarez with your request so we can coordinate and increase your quota if necessary.

# Computing Environment 

No compute tasks should be done on the login nodes since those are meant to operate only as bastion hosts, not for doing analysis or accessing data. Instead, use the "iana" pool of interactive nodes. A typical login session would be:
```
% ssh username@s3dflogin.slac.stanford.edu
% ssh iana
```
Should you need dedicated resources for an interactive job, you can use, e.g.
```
srun --account kipac:kipac --partition roma --qos=normal --cpus-per-task=1 --mem=256G --time=00:10:00 --pty /bin/bash
```
Note the `<facility>:<repo>` repo pattern (where both are `kipac`) which should help reduce queue times and prevent preemption, whether the jobs are interactive or not. See [here](https://s3df.slac.stanford.edu/#/batch-compute) for more details.

## Interactive Slurm Command Templates

Use `--account kipac:kipac` for KIPAC allocation, request one CPU explicitly with `--cpus-per-task=1`, and request 256 GB with `--mem=256G`.

GPU partitions (`1 GPU + 1 CPU + 256 GB`):

```bash
# ada (L40S)
srun   --account kipac:kipac --partition ada    --qos=normal      --gres=gpu:1 --cpus-per-task=1 --mem=256G --time=00:10:00 --pty /bin/bash
salloc --account kipac:kipac --partition ada    --qos=normal      --gres=gpu:1 --cpus-per-task=1 --mem=256G --time=00:10:00

# ampere (A100) - preemptable QoS for kipac:kipac
srun   --account kipac:kipac --partition ampere --qos=preemptable --gres=gpu:1 --cpus-per-task=1 --mem=256G --time=00:10:00 --pty /bin/bash
salloc --account kipac:kipac --partition ampere --qos=preemptable --gres=gpu:1 --cpus-per-task=1 --mem=256G --time=00:10:00

# hopper (H200)
srun   --account kipac:kipac --partition hopper --qos=normal      --gres=gpu:1 --cpus-per-task=1 --mem=256G --time=00:10:00 --pty /bin/bash
salloc --account kipac:kipac --partition hopper --qos=normal      --gres=gpu:1 --cpus-per-task=1 --mem=256G --time=00:10:00
```

CPU-only partitions (`1 CPU + 256 GB`):

```bash
# milano
srun   --account kipac:kipac --partition milano --qos=normal --cpus-per-task=1 --mem=256G --time=00:10:00 --pty /bin/bash
salloc --account kipac:kipac --partition milano --qos=normal --cpus-per-task=1 --mem=256G --time=00:10:00

# roma
srun   --account kipac:kipac --partition roma   --qos=normal --cpus-per-task=1 --mem=256G --time=00:10:00 --pty /bin/bash
salloc --account kipac:kipac --partition roma   --qos=normal --cpus-per-task=1 --mem=256G --time=00:10:00
```

To target only high-memory Milano nodes, add:

```bash
--constraint='MEM_SZE:1920GB'
```
