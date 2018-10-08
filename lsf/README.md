Basic Usage
-----------
NOTE: See this [presentation](https://www.slac.stanford.edu/exp/glast/wb/prod/pages/installingOfflineSW/LSF_at_SLAC.pdf) for an overview of LSF from SLAC.

Jobs are submitted via
```
bsub -J <job name> -oo <combined stdout and stderr> -n <number of cores> -q <computing queue> <exec> <args>
```
They can also be submitted via scripts with
```
bsub < job.script.lsf
```
See the example scripts in this directory.

The command `bjobs` will give you your job status. It is useful to keep some
aliases (for c shell)
```
alias qr 'bjobs -u <username> -r'
alias q 'bjobs -u <username>'
alias qh 'bjobs -u <username> -a'
```
where `q` lists all jobs (pending and running), `qr` lists only running jobs and `qh` lists all jobs, even
those that have completed.

These next aliases help with seeing where you are in a queue and
how much usage a given machine has
```
alias qaro 'bjobs -q kipac-ibq -u all -r'
alias qao 'bjobs -q kipac-ibq -u all'
```
The queue name `kipac-ibq` can be replaced by any other queue name of course.

To check in on your jobs, use `bpeek <job number>`. Specifying `-f` will follow
the output like `tail -f`.

Killing jobs is done via `bkill`. `bkill 0` will kill all of your jobs.

Job Arrays
----------
Job arrays let you run and control lots of similar jobs. See this [website](https://www.ibm.com/support/knowledgecenter/SSETD4_9.1.3/lsf_admin/job_arrays_lsf.dita) for
more details.

The basic idea is that each job in the array is specified by a
number. The name of the job itself when submitted contains the range of numbers used like this
```
bsub -J JobName[1-1000]%100 -oo jobout.%I.oe -q <queue> <exec> input.%I
```
In this case the array is from 1 to 1000. The `%100` is optional
and if specified forces the array to only use 100 cores at a time. This
parameter is called the `slot limit`.

Input can be controlled in several different ways. You can use put the input into files
like `input.1, input.2, ...` and then use `%I` in the job submission (see above). LSF knows
to replace this with the index of the job in the array. This parameter can also be used to tag the
output with the array index of the job as seen above. If your job reads from the environment, the variable
`$LSB_JOBINDEX` will hold the array index of the job. It defaults to zero if there is no array.

Job arrays can be killed in a single command via
```
bkill <job number>
```
Individual jobs in the array can be killed via
```
bkill "<job number>[index]"
```

The same syntax for `bkill` above can be used for `bjobs` to display the status of jobs in the array 

Tips and Tricks
---------------
There are a few tricks for LSF that might be useful.

0) All command line parameters (i.e. `-J`, etc.) can be put into a script that looks like
```
#!/bin/bash
#BSUB -J JobName
...
```

1) Put `%J` in output and error file names to have them tagged with the job number.

2) You can get email when your job is complete, starts to run, etc. via
```
#BSUB -u <email address>
#mail at start
#BSUB -B
#mail at end
#BSUB -N
```

3) You can run over any set of cores like this
```
#BSUB -R order[slots]
#BSUB -R span[hosts=-1]
#BSUB -n <total number of MPI tasks>
```

4) You can use `mpirun` in jobs by removing `#BSUB -a mympi` from scripts.
To do this you have to submit from the head node of the system. Then you can call
your program via
```
mpirun <exec1> <args1>
mpirun <exec2> <args2>
```
You do not need to specify `-n` or `-np`.

5) Use `-x` for exclusive execution (i.e., your job will be the only one on the node).

6) You can use fewer cores than given on a node via
```
#BSUB -R span[ptile=<number of cores per node>]
```

7) You can select host types via
```
#BSUB -R "linux64 && rhel60 && scratch > 2"
```
In this case, your job will only run on hosts with 64 bit linux, RHEL6.0 and
at least 2 GB of scratch space.

8) SLAC has general computing queues. By submitting a job just with a wall time limit,
it will get routed to the correct queue (medium, long, etc.). This can be done via
```
#BSUB -W HH:MM
```
See the [general queues](https://confluence.slac.stanford.edu/display/SCSPub/High+Performance+Computing+at+SLAC) for
more details. 

Resource Monitoring
-------------------

It is important to monitor resource usage when you are running a large number of jobs. A good introduction to batch computing resource monitoring was written for the Fermi Collaboration and can be found [here](https://confluence.slac.stanford.edu/x/KY_PCg). 

One of the most useful tools for monitoring resource usage is the [Ganglia](http://ganglia.sourceforge.net/) monitoring system. SLAC has Ganglia monitoring setup for almost everything (fileservers, interactive nodes, batch nodes, etc.); however, it can sometimes be hard to find what you are looking for. Below are a set of resources to help.


### Fileservers

Overloading the I/O of the SLAC fileservers is the single largest point of stress for batch computing. SLAC hosts several different types of filesystems (afs, nfs, gpfs, etc.) and each has it's own advantages, disadvantages, and limitations (Tom Glanzman wrote a great breakdown [here](https://confluence.slac.stanford.edu/x/KY_PCg#BestPracticesforUsingtheSLACBatchSystem-GeneralGuidelinesforUsingRemoteFileServers)). To figure out what fileserver resources your jobs will be hitting, change to the directories where you will be reading/writing data and run `df -h .`. The output will tell you the fileserver, usage, and mount point of that directory. Several examples are shown below:

```
cd $HOME
df -h .
Filesystem      Size  Used Avail Use% Mounted on
AFS             8.6G     0  8.6G   0% /afs
fs whereis .
File . is on host yfs03.slac.stanford.edu 

cd /nfs/slac/g/ki/ki03/kadrlica
df -h .
Filesystem            Size  Used Avail Use% Mounted on
wain002:/g.ki.ki03/kadrlica
                      300G  284G   17G  95% /nfs/slac/g/ki/ki03/kadrlica

cd /nfs/slac/g/ki/ki19
df -h .
Filesystem           Size  Used Avail Use% Mounted on
ki-nfs02:/g.ki.ki19   86T   80T  6.2T  93% /nfs/slac/g/ki/ki19
```

Now that we know the fileserver, we'd like to use Ganglia to track our usage. Unfortunately, it is not always straight forward to find the appropriate webpage. For the most part you can find the information you need from the [alldomains](http://ganglia.slac.stanford.edu:8080/ganglia/alldomains/) Ganglia page, but to we've also listed some of the most common resources:

* [alldomains](http://ganglia.slac.stanford.edu:8080/ganglia/alldomains/) - This is where to start if you don't know where you are going
* [afs](http://ganglia.slac.stanford.edu:8080/ganglia/fileservers/?r=12_hours&s=descending&c=afs) - your home directory
* [wain](http://ganglia.slac.stanford.edu:8080/ganglia/fileservers/?r=12_hours&s=descending&c=nfs-wain-kipac) - many old `/nfs/g/ki/` mounts 
* [ki-nfs](http://ganglia.slac.stanford.edu:8080/ganglia/alldomains/?r=12_hours&s=descending&c=nfs-rhel-kipac) - newer `/nfs/g/ki` mounts

### Compute Nodes

You can find compute node usage through Ganglia as well. This can be useful for monitoring the load on interactive and/or cluster machines, specifically if a large number of nodes are down.

* [rhel6-64](http://ganglia.slac.stanford.edu:8080/ganglia/alldomains/?r=12_hours&s=descending&c=rhel6-64) - interactive nodes running rhel6-64bit
* [ki-ls](http://ganglia.slac.stanford.edu:8080/ganglia/alldomains/?r=12_hours&s=descending&c=ki-ls) - interactive kipac nodes
* [bullet](http://ganglia.slac.stanford.edu:8080/ganglia/alldomains/?r=12_hours&s=descending&c=bullet) - bullet mpi cluster
* [hequ](http://ganglia.slac.stanford.edu:8080/ganglia/alldomains/?r=12_hours&s=descending&c=hequ) - hequ batch nodes (other nodes such as `deft`, `fell`, etc. can be found similarly)