SSH and SLAC
------------
See this web page http://www.slac.stanford.edu/comp/unix/ssh.html. It
seems to be updated regularly.

Known Hosts and Load-balanced Pools
-----------------------------------
SLAC has load-balanced pool names (like rhel6-64 or ki-ls)
which direct you to least loaded member of the pool. For SSH this
can cause issues. The solution is download the SLAC known_hosts file here

ftp://ftp.slac.stanford.edu/admin/known_hosts

Once you merge it with your own .ssh/known_hosts file (you can use [this script](get_slac_known_hosts.py)), you should not
see any issues. As the pools change over time, you may have to repeat this.

Fixing Server Timeouts from Campus
----------------------------------
If you have been having trouble with server timeouts from campus, try adding this to your `~/.ssh/config`
```
Host *
ServerAliveInterval 60
```

