#!/bin/bash

#get your lustre quota
/afs/slac/package/lustre/scripts/my_lustre_quota

#change your default login shell
# should work from most unix hosts, def. works from rhel6-64
/usr/local/bin/ypchsh

#C-shell alias for looking at nfs quota
# run this while your current working directory
# is in the nfs file system
alias slacquota 'df -h `pwd`'

#use intel compilers
#probably out of date
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



