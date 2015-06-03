# wav_read/wav_write
These are rewritten Functions of `wavread` and `wavwrite` using `audioread` and
`audiowrite`. They are using the same syntax as the original implementation. For
further usage information, please look at the original documentation of
`wavread` and `wavwrite`, which are part of the files.

## wav_read
The function `wav_read` behaves like the original `wavread` except for the
output `opts` in `wavread`, which is not implemented yet.


Usage example:
```matlab
[y, fs, nbits] = wav_read(file)
[size, fs] = wav_read(file, 'size')
```

## wav_write
The function `wav_write` can be used exactly like the original `wavwrite`.

Usage:
```matlab
wav_write(y, fs, nbits, 'filename')
wav_write(y, fs, 'filename')
wav_write(y, 'filename')
```

## Test setup
There is a unit test for each function, which is checking for differences
between the old `wavread`/`wavwrite` and the new `wav_read`/`wav_write`. To run
the tests run `runtests('wav_readTest.m')` and `runtests('wav_writeTest.m')` (or
simply `runtests` in Matlab > 2015a).

## WAV_to_newWAV.py
This python Script recursively searches for all `wavread` and `wavwrite`
commands in .m files in your current working directory and subdirectories and
changes them to `wav_read` and `wav_write`. A log-file is created in the current
directory, which lists all changes.

Please only use it if you know what your're doing. It is recommended to make an
backup of the files you want to change.

---------------
This project is licensed under the terms of the MIT license.
