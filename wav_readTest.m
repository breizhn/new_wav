% Script to test and compare the function wav_read.m with the "old"
% Author: Nils L. Westhausen 
%        (c) TGM @ Jade Hochschule (MIT license).
% Version History:
% Ver. 0.0.0 initial create (empty)       13-Apr-2015           NW
% Ver. 1.0.0 First Implementation         06-May-2015           NW
% Ver. 1.1.0 new test-names               15-May-2015           NW
% Ver. 1.2.0 changed name to wav_read     28-May-2015           NW
% Ver. 1.3.0 updated: new input handling  06-Jun-2015           NW
randn_vec = randn(1,96000);
max_vec = max(max(randn_vec));
randn_vec = randn_vec./ max_vec;
audiowrite('test_audio.wav', randn_vec, 48000)
%-------------------------------------------------------------------------
%% Testing returning of empty struct with four output arguments

[y, fs, nbits, opt] = wav_read('test_audio.wav');
if ~isempty(opt) && ~isa('opt','struct')
    error('not returning empty struct, when called with four output arguments')
end

%% Output of wavread(filename) should be the same as wav_read(filename)

[y_new, fs_new, nbits_new] = wav_read('test_audio');
[y_old, fs_old, nbits_old] = wavread('test_audio');
if ~mean(y_new == y_old)
    error('the data is not equal')
end
if fs_old ~= fs_new
    error('the sampling rate is not the same')
end
if nbits_old ~= nbits_new
    error('The bits per sample are not equal')
end

%% Output of wavread(..., 'size') should be the same as wav_read(..., 'size')

[siz_new, fs_new] = wav_read('test_audio','size');
[siz_old, fs_old] = wavread('test_audio','size');

if siz_old ~= siz_new
    error('the size struct is not equal')
end
if fs_old ~= fs_new
    error('the sampling rate is not the same')
end

%% Output of wavread(..., N) should be the same as wav_read(..., N)

[y_new] = wav_read('test_audio',800);
[y_old] = wavread('test_audio',800);
if length(y_new) ~= length(y_old)
    error('the length of the data is not equal')
end
if ~mean(y_new == y_old)
    error('the data is not equal')
end
   
%% Output of wavread(..., [N1 N2]) should be the same as wav_read(..., [N1 N2])
[y_new] = wav_read('test_audio',[800 60000]);
[y_old] = wavread('test_audio',[800 60000]);
if length(y_new) ~= length(y_old)
    error('the length of the data is not equal')
end
if ~mean(y_new == y_old)
    error('the data is not equal')
end

%% Output of wavread(..., 'native') should be the same as wav_read(..., 'native')
[y_new] = wav_read('test_audio','native');
[y_old] = wavread('test_audio','native');
if ~mean(y_new == y_old)
    error('the data is not equal')
end
%% Output of wavread(..., 'double') should be the same as wav_read(..., 'double')
[y_new] = wav_read('test_audio','double');
[y_old] = wavread('test_audio','double');
if ~mean(y_new == y_old)
    error('the data is not equal')
end
%% Error returning with too much input arguments
try
    [y_new] = wav_read('test_audio',[1 300],'native','test_what_happens');
catch err
    if ~strcmp(err.identifier, 'wav_read:invalid_input')
        error('not returning the right error')
    end
end
%%
delete('test_audio.wav')
