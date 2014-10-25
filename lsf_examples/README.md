There are a few tricks for LSF that might be useful.

1. Put `%J` in output and error file names to have them tagged with the job number.
1. `bkill 0` kills all of your jobs
1. You can get email when your job is complete, starts to run, etc. via
```
#BSUB -u <email address>
#mail at start
#BSUB -N
#mail at end
#BSUB -B
```
1. You can run over any cores like this
```
#BSUB -R order[slots]
#BSUB -R span[hosts=-1]
#BSUB -n <total number of MPI tasks>
```
1. You can use `mpirun` in jobs by removing `#BSUB -a mympi` from scripts.
To do this you have to submit from the head node of the system. Then you can call
you program via
```
mpirun <exec1> <args1>
mpirun <exec2> <args2>
```
You do not need to specify `-n` or `-np`.
1. See array.lsf for submitting job arrays.
1. Use `-x` for exclusive execution (i.e., your job will be the only one on the node).
1. You can use fewer cores than given on a node via
```
#BSUB -R span[ptile=<number of cores per node>]
```


