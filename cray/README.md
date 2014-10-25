The Cray
========
The cray is located on campus at crayola.stanford.edu. You will
need to ask Stuart for access.

Logging In
----------
Users cannot change their passwords on the cray,
so it is best to set an SSH key.

File Systems
------------
The cray has a large 32 TB drive at
```
/dvs/cab2-32T/xtusers/beckermr
```
Only this drive can be seen from the compute nodes.

Environment
-----------
The cray has a fill module system. To use the gcc compilers,
put this in your .bashrc
```
module swap PrgEnv-pgi PrgEnv-gnu
```

Compiling Code
--------------
To compile code, use the cray wrapper `cc`.
There are no shared libraries on the cray. However,
you can compile your own libs in your home area and
link them statically into your executable.

Running Code
------------
The cray uses PBS to manage batch jobs. Submit jobs with `qsub`
using a script like this
```
qsub job.pbs
```
where `job.pbs` looks like
```
#PBS -S /bin/bash
#PBS -l walltime=48:00:00
#PBS -l ncpus=16
#PBS -N jobName

cd $PBS_O_WORKDIR
/usr/bin/aprun -n 16 <exec> <args>
```

The command `qstat` displays the status of jobs. Some aliases
that might be useful are
```
alias q='qstat -an1 | grep <username> '
alias qr='qstat -n1r | grep <username> '
alias qa='qstat -an1'
alias qar='qstat -n1r '
```

Moving Data
-----------
The cray is an island universe. You can use rsync to
move data to other places. Ask Stuart about his automated
rsync scripts.
