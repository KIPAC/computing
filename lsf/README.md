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
Job arrays let you run and control lots of similar jobs. See this [website](http://www.ccs.miami.edu/hpc/lsf/7.0.6/admin/jobarrays.html) for
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
See the [general queues](http://www.slac.stanford.edu/comp/unix/farm/gen_queue.pdf) for
more details. 
