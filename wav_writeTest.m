% Script to test and compare the function wav_write.m with the "old"
% wavwrite
% Author: Nils L. Westhausen 
%        (c) TGM @ Jade Hochschule (MIT license).
% Version History:
% Ver. 0.0.0 initial create (empty)     13-Apr-2015           NW
% Ver. 1.0.0 First Implementation       06-May-2015           NW
% Ver. 1.1.0 new testnames              15-May-2015           NW
% Ver. 1.2.0 added test                 15-May-2015           NW
% Ver. 1.3.0 changed name to wav_write  28-May-2015           NW
%------------------------------------------------------------------------- 
%
%% Testing of Error returning by calling only with one arguement
data = randn(1,48000).*0.2;
try
    wav_write(data);
    
catch err
    switch err.identifier
        case 'wav_write:notEnoughArgs'
            
        otherwise
            error('not returning error, when called only with one input argument')
    end
end

%% Testing of writing without .wav extesion
data = randn(1,48000).*0.2;
filename = 'test';
fs =48000;
try
    wav_write(data,fs,filename);
    
catch err
    error('writing without .wav extesion not possible')
    
end

delete([filename '.wav'])
%% Output of wavwrite(data, filename) should be the same as wav_write(data, filename)

data = randn(1,48000).*0.2;

filename1 = 'test1';
filename2 = 'test2';

wavwrite(data ,filename1)
wav_write(data, filename2)

[y_old, fs_old] = audioread([filename1 '.wav']);
[y_new, fs_new] = audioread([filename2 '.wav']);

nbits_old = audioinfo([filename1 '.wav']);
nbits_old = nbits_old.BitsPerSample;
nbits_new = audioinfo([filename2 '.wav']);
nbits_new = nbits_new.BitsPerSample;

if fs_old ~= fs_new
    error('the sampling rate is not the same')
end

if any(find(abs(y_old - y_new)> 0.01))
    error('the data is not equal')
end

if nbits_old ~= nbits_new
    error('The bits per sample are not equal')
end

delete([filename1 '.wav'], [filename2 '.wav'])
%% Output of wavwrite(data, fs, filename) should be the same as wav_write(data, fs, filename)

data = randn(1,48000).*0.2;
fs =48000;
filename1 = 'test1';
filename2 = 'test2';

wavwrite(data, fs ,filename1)
wav_write(data, fs, filename2)

[y_old, fs_old] = audioread([filename1 '.wav']);
[y_new, fs_new] = audioread([filename2 '.wav']);

nbits_old = audioinfo([filename1 '.wav']);
nbits_old = nbits_old.BitsPerSample;
nbits_new = audioinfo([filename2 '.wav']);
nbits_new = nbits_new.BitsPerSample;

if fs_old ~= fs_new
    error('the sampling rate is not the same')
end

if any(find(abs(y_old - y_new)> 0.01))
    error('the data is not equal')
end

if nbits_old ~= nbits_new
    error('The bits per sample are not equal')
end

delete([filename1 '.wav'], [filename2 '.wav'])
%% Output of wavwrite(data, fs, nbits, filename) should be the same as wav_write(data, fs, nbits, filename

data = randn(1,48000).*0.2;
fs =48000;
nbits = 8;
filename1 = 'test1';
filename2 = 'test2';

wavwrite(data, fs , nbits,filename1)
wav_write(data, fs, nbits, filename2)

[y_old, fs_old] = audioread([filename1 '.wav']);
[y_new, fs_new] = audioread([filename2 '.wav']);

nbits_old = audioinfo([filename1 '.wav']);
nbits_old = nbits_old.BitsPerSample;
nbits_new = audioinfo([filename2 '.wav']);
nbits_new = nbits_new.BitsPerSample;

if fs_old ~= fs_new
    error('the sampling rate is not the same')
end

if any(find(abs(y_old - y_new)> 0.01))
    error('the data is not equal')
end

if nbits_old ~= nbits_new
    error('The bits per sample are not equal')
end

delete([filename1 '.wav'], [filename2 '.wav'])

