python
======

Python at KIPAC can be a bit tricky, but the steps below, using [miniconda](http://conda.pydata.org/miniconda.html), should result in a generally useful setup. 


## Setup

1. (Optional) If you're academic user, request an academic license here [on this page](https://store.continuum.io/cshop/academicanaconda). 
   You should receive an email with a license file, which you'll put it under `~/.continuum`.
   
2. Download minicoda and install it. Follow the install instruction.
   
   ``` 
   wget https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
   bash Miniconda-latest-Linux-x86_64.sh
   ```
   
3. Add `setenv PATH "${HOME}/miniconda/bin:${PATH}"` to your `~/.cshrc` file. Change `${HOME}/miniconda` to the correct path if you did not choose the default path in previous step. Once this is done, source your `~/.cshrc`:
   
   ```
   source ~/.cshrc
   ```
   
4. Install packages
   
   ```
   conda update conda
   conda install numpy scipy matplotlib ipython jupyter astropy scikit-learn
   conda install mkl  # (only if you did Step 1)
   ```
   
5. Some additional packages need to be install via `pip`, for example:
   
   ```
   pip install healpy
   ```
   
6. You're good to go!
