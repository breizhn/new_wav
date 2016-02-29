# wav_read/wav_write
These are rewritten Functions of `wavread` and `wavwrite` using `audioread` and
`audiowrite`. They are using the same syntax as the original implementation. For
further usage information, please look at the original documentation of
`wavread` and `wavwrite`, which is included in the function-files. Due to the 
removal of the old `wavread()`/`wavwrite()` since Matlab R2015b the function 
was also renamed to `wavread()`/`wavwrite()` to provide an easy usage without 
renaming.

## wav_read
The function `wav_read` behaves like the original `wavread` except for the
output `opts` in `wavread`, which is not implemented.


Usage example:
```matlab
[y, fs, nbits] = wav_read(file)
[siz, fs] = wav_read(file, 'size')
```

## wav_write
The function `wav_write` can be used exactly like `wavwrite`.

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
simply `runtests` in MATLAB > 2015a). The test will not work in MATLAB > R2015b, 
because `wavread`/`wavwrite` was removed.


---------------
This project is licensed under the terms of the MIT license.

