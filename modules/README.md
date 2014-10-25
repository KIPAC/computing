Usage
-----
To use these, you need to have
```
module load use.own
```
in your .bashrc or .cshrc

Place the module files in a directory called `privatemodules`
in your home area. Diffreent versions of the same package are stored
as files in subdirectories so that
```
privatemodules/fft2/2.1.4
privatemodules/fft2/2.1.5
```
are module files for `fftw2` versions 2.1.4 and 2.1.5. These are loaded via
```
module load fftw2/2.1.4
module load fftw2/2.1.5
```

Writing
-------

Writing a module file is not terribly hard. See the examples in
this repo and see [http://linux.die.net/man/4/modulefile].

Please submit new modules back to this repo via a pull request!






