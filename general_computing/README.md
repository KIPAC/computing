Getting Started
===============

Documentation
-------------
Try these websites

http://www.slac.stanford.edu/comp/unix/unix-hpc.html  
http://kipac.stanford.edu/collab/computing  
https://confluence.slac.stanford.edu/display/KIPAC/Computing

Getting help
------------
If all else fails, email `unix-admin@slac.stanford.edu`

Tips for general computing at SLAC
==================================

See current SLAC compute usage
------------------------------
SLAC has monitoring of a lot of its resources via a system called ganglia. You
can see the load on each system output from ganglia here

http://ganglia.slac.stanford.edu:8080/?m=load_one&r=12_hours&s=ascending&hc=4&mc=2

This can be especially useful if your nfs server is non-responsive due to a large
amount of I/O from a single user.

No backups
----------
Data put into `nobackup` directories on NFS is not backed up.

Change your afs allocation
--------------------------
You can increase your own afs quota for your home area up to 20 GB [here](https://www.slac.stanford.edu/comp/unix/auth/afs-self.shtml). For general afs information, see this 
[webpage](https://www.slac.stanford.edu/comp/unix/afs-req.html).

Change your password
--------------------
You can change your password [here](https://unix-password.slac.stanford.edu/chpw/kpasswd1.pl) (even if it has expired).

SLAC Public Machines
--------------------
A description of SLAC's public machines is [here](http://www.slac.stanford.edu/comp/unix/public-machines.html).

Check quota
-----------
### lustre quota
Run the script `/afs/slac/package/lustre/scripts/my_lustre_quota`

### AFS quota
Run
```
fs listquota -human ~
```

### NFS quotas
Running 
```
df -h 
```
from within your nfs space should return your usage and quota.

Change your default login shell
-------------------------------
Run 
```
/usr/local/bin/ypchsh
```
This should work from most unix hosts and definitely 
works from rhel6-64.

Intel compilers
----------------
NOTE: This is probably out of date.
For c shell, use
```
setenv OMPI_CC `which icc`
setenv OMPI_CXX `which icpc`
setenv OMPI_FC `which ifort`
setenv OMPI_F77 `which ifort`
source /afs/slac/package/intel_tools/prod/bin/compilervars.csh intel64
if !($?LD_LIBRARY_PATH) then
    setenv LD_LIBRARY_PATH /afs/slac.stanford.edu/package/intel_tools/2013u0/composer_xe_2013.0.079/compiler/lib/intel64
else
    setenv LD_LIBRARY_PATH /afs/slac.stanford.edu/package/intel_tools/2013u0/composer_xe_2013.0.079/compiler/lib/intel64:${LD_LIBRARY_PATH}
endif
```
Bash will be similar.


