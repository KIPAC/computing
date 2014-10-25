There are a few tricks for LSF that might be useful.

1) Put %J in output and error file names to have them tagged with the job number.

2) 'bkill 0' kills all of your jobs

3) You can get email when your job is complete, starts to run, etc. via

    #BSUB -u <email address>
    #mail at start
    #BSUB -N
    #mail at end
    #BSUB -B

