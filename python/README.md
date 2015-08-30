python
======

Python at KIPAC can be a bit tricky, but the steps below, using [miniconda](http://conda.pydata.org/miniconda.html), should result in a generally useful setup. 


## Setup

1. Run
    
    ```
    anaconda
    conda list
    ```
    
   See if you are happy with these python packages (and their versions). If you do, append the following lines to your `~/.cshrc` file:
    
    ```
    setenv PATH "/afs/slac.stanford.edu/package/anaconda/anaconda/bin:$PATH"
    setenv HEP_ENV true
    ```
    
   And you are done, ignore the rest of instructions. 
   
   If you want some other packages or more up-to-date packages, follow the steps below.

1. (Optional) If you're academic user, request an academic license here [on this page](https://store.continuum.io/cshop/academicanaconda). 
   You should receive an email with a license file, which you'll put it under `~/.continuum`.
   
2. Quit the anaconda shell (if you don't know what this means, just log out and log in again). 
   Download minicoda and install it:
    
   ``` 
   wget https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
   bash Miniconda-latest-Linux-x86_64.sh
   ```
    
   Follow the installation instruction. It might be a good idea to use the full AFS path `/afs/slac.stanford.edu/u/ki/<your user id>/miniconda` as the installation path.  
   
3. Append the following lines to your `~/.cshrc` file. Change `/afs/slac.stanford.edu/u/ki/<your user id>/miniconda` to the path you entered in the previous step.
    
    ```
    setenv PATH "/afs/slac.stanford.edu/u/ki/<your user id>/miniconda/bin:$PATH"
    setenv HEP_ENV true
    ```
    
   Once this is done, source your `~/.cshrc`:
    
   ```
   source ~/.cshrc
   ```
   
4. Update conda and install additional packages. Here's an 
    
   ```
   conda update conda
   conda update --all
   conda install numpy scipy matplotlib ipython jupyter pandas astropy scikit-learn
   conda install mkl  # (only if you did Step 2)
   ```
   
5. Some additional packages need to be install via `pip`, for example:
    
   ```
   pip install healpy
   ```
   
6. Clean up some tarball files to save disk space:
     
     ```
     conda clean -t
     ```
     

7. You're good to go!
