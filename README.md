# wav_read/wav_write
These are rewritten Functions of `wavread` and `wavwrite` using `audioread`
and `audiowrite`. They are using the same syntax like the original implementation.
For further usage information, please look at the original documentation of
 `wavread` and `wavwrite`, which are part of the files.

## wav_read
The function `wav_read` behaves like the original `wavread`. Please note the
struct `opt` which exits as output in the `wavread` function is not implemented yet.


Usage example:
```matlab
[y, fs, nbits] = wav_read(file)
[size, fs] = wav_read(file, 'siz')
```


## wav_write
The function `wav_write` can be used exactly like the original `wavwrite`.
All cases are possible.

Usage:
```matlab
wav_write(y, fs, nbits, 'filename')
wav_write(y, fs, 'filename')
wav_write(y, 'filename')
```


## Test setup
There is a unit test for each function, which is checking for differences
between the new an the old one. To use the tests run `runtests('wav_readTest.m')`
and `runtests('wav_writeTest.m')`

## WAV_to_newWAV.py
This python Script searches for all `wavread` and `wavwrite` commands in
.m files in your current python working directory and subdirectories and change
them to `wav_read` and `wav_write`. It is a log-file created in your cwd,
in which all changes are listed.

Please only use it if you know what your're doing.
It is recommended to make an backup of the files you want to change.



---------------
This project is licensed under the terms of the MIT license.
