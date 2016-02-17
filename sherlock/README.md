Getting Started
===============

Documentation
-------------
Try these websites

http://sherlock.stanford.edu/mediawiki/index.php/Main_Page

Getting help
------------

Research Computing support can be reached by sending an email to research-computing-support@stanford.edu and mentioning 'Sherlock'.

KIPAC Specific Sherlock-isms
----------------------------

1. The KIPAC has its own partition, named `iric`. You can submit to this partition via putting `#SBATCH --partition=iric` in your SLURM batch script.

2. The KIPAC also has its own scratch space at `/scratch/PI/kipac`. This space can be accessed automatically via the `$PI_SCRATCH` environment variable. 

3. There is more permantent space for KIPAC computing at `/share/PI/kipac`. This space can be accessed automatically via the `$PI_HOME` environment variable. 


