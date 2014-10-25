Tips for general computing at SLAC
==================================

See current SLAC compute usage
------------------------------
SLAC has monitoring of a lot of its resources via a system called ganglia. You
can see the load on each system output from ganglia here

http://ganglia.slac.stanford.edu:8080/?m=load_one&r=12_hours&s=ascending&hc=4&mc=2

This can be especially useful if you nfs server is non-responsive due to a large
amount of I/O from a single user.

No backups
----------
Data put into `nobackup` directories on NFS is not backed up.

Change your afs allocation
--------------------------
You can increase your own afs quota for home up to 20 GB [here](https://webauth1.slac.stanford.edu/login/?RT=VEtcqWQT0uv/xh9aeS/ILez4O6FGZF0CxZB9lMmXRk9LfYaK00uBOiuxifZzQB8cKWrPrZdU655XTKk0rzZbrEfGG3Bo9FceuOmJ8Hd73pfhMv0VaCvHLtqU7JXQd+arjRefwmc1aNEJdPxz5wVlDDSIOepRipEW6HCozI4g0ZwbSmERTxA1e2EhiIpe8WWtUaxZhekj2/mEjwm3N6OaXmsc+lyKaY+uBVrXhtRwMw6WkFPHfzHj2Ax1DNZK4Ehk+9dOLBkUd8xrr0ErKRSg/rHxSHyJ1xipfuKZjsia+oeK9SHI;ST=VDPV/Fcca0ru3l8MbnOKotWaTlP9gwb8wBLB1Zrqwt9EjH5BC5bINbkgKN35hAWOf/PhRxi1A3YRy1Pt1bzTz0kHHP9CnylPA+o8lnpvaokthBSLfsoi/tCB7IsE3ooa14FbBh+f4tj8rtZcZWTrq7CEE1K4Uukn4MJJiaEw4dehEbhau08tbY4QJj1vxR4rO3HSnA==).

Change your password
--------------------
You can change your password [here](https://unix-password.slac.stanford.edu/chpw/kpasswd1.pl) (even if it has expired).

SLAC Public Machines
--------------------
A description of SLAC's public machines is [here](http://www.slac.stanford.edu/comp/unix/public-machines.html).

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


