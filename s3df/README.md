# Getting Started

The [SLAC Shared Science Data Facility (S3DF)](https://s3df.slac.stanford.edu) is a compute, storage and network facility supporting SLAC science.

## Documentation

Documentation is available [here](https://s3df.slac.stanford.edu/public/doc/#/).

## Getting help

For getting help and reporting problems email s3df-help@slac.stanford.edu.

For general discussion see the #comp-sdf channel on the SLAC Slack workspace.

## Getting an Account

If you are a SLAC employee or affiliated researcher (i.e. with KIPAC) with a SLAC Unix account, you are eligible for an S3DF account. To enable your S3DF account, log into [coacct](https://coact.slac.stanford.edu/) using your SLAC Unix credentials and follow the instructions to request membership in the KIPAC S3DF facility.

## KIPAC Specific Resources

There are 3 [clusters](https://s3df.slac.stanford.edu/public/doc/#/batch-compute?id=clusters-amp-repos) (–partitions in Slurm terminology) at S3DF: Roma, Milano, and Ampere (GPU). KIPAC facility S3DF members have priority access (non-preemptable jobs) on 20 Roma nodes. Each Roma node has 128 AMD EPYC 7702 cores and 512 GB RAM. KIPAC facility S3DF members can also run low-priority preemptable jobs on Milano and the GPU cluster Ampere.

## Note About S3DF data storage for KIPAC

KIPAC is currently in the process of obtaining over 1PB in new data storage on S3DF. In the meantime we are handling data storage requests on a case-by-case basis. If you need more storage than available in your home directory or `/sdf/scratch/kipac/`, please submit a ticket describing your storage needs [here](https://slacprod.servicenowservices.com/gethelp.do).

## Tips and Tricks

No compute tasks should be done on the login nodes since those are meant to operate only as bastion hosts, not for doing analysis or accessing data. Instead, use the "iana" pool of interactive nodes. A typical login session would be:
```
% ssh username@s3dflogin.slac.stanford.edu
% ssh iana
```

