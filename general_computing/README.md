Tips for general computing at SLAC
==================================

Get your lustre quota
---------------------
Run the script `/afs/slac/package/lustre/scripts/my_lustre_quota`

Change your default login shell
-------------------------------
Run 
```
/usr/local/bin/ypchsh
```
This should work from most unix hosts and definitely 
works from rhel6-64.

NFS quotas
----------
Running 
```
df -h 
```
from within your nfs space should return your usage and quota.

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


