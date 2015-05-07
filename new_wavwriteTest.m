% Script to test and compare the function new_wavwrite.m with the "old"
% wavwrite
% Author: Nils L. Westhausen (c) TGM @ Jade Hochschule applied licence see EOF 
% Version History:
% Ver. 0.01 initial create (empty) 13-Apr-2015 			 NW
% Ver. 0.08 First Implementation   06-May-2015           NW
%clear;
%close all;
%clc;
%
%------------------------------------------------------------------------- 
%
%% Testing of Error returning by calling only with one arguement
data = randn(1,48000).*0.2;
try
    new_wavwrite(data);
    
catch err
    switch err.identifier
        case 'myApp:argChk1'
            
        otherwise
            error('not returning error, when called only with one input argument')
    end
end

%% Testing of Error returning by calling with two arguements
data = randn(1,48000).*0.2;
filename = 'test.wav';
try
    new_wavwrite(data,filename);
    
catch err
    switch err.identifier
        case 'myApp:argChk2'
            
        otherwise
            error('not returning error, when called with two input arguments')
    end
end

%% Testing of writing without .wav extesion
data = randn(1,48000).*0.2;
filename = 'test';
fs =48000;
try
    new_wavwrite(data,fs,filename);
    
catch err
    error('writing without .wav extesion not possible')
    
end

delete([filename '.wav'])
%% Testing of the equality of new and old wavwrite for (data,fs,filename)
data = randn(1,48000).*0.2;
fs =48000;
filename1 = 'test1';
filename2 = 'test2';

wavwrite(data, fs ,filename1)
new_wavwrite(data, fs, filename2)

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
%% Testing of the equality of new and old wavwrite for (data,fs, nbits,filename)
data = randn(1,48000).*0.2;
fs =48000;
nbits = 8;
filename1 = 'test1';
filename2 = 'test2';

wavwrite(data, fs , nbits,filename1)
new_wavwrite(data, fs, nbits, filename2)

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

%--------------------Licence ---------------------------------------------
% Copyright (c) <2015> Nils L. Westhausen
% Jade University of Applied Sciences 
% Permission is hereby granted, free of charge, to any person obtaining 
% a copy of this software and associated documentation files 
% (the "Software"), to deal in the Software without restriction, including 
% without limitation the rights to use, copy, modify, merge, publish, 
% distribute, sublicense, and/or sell copies of the Software, and to
% permit persons to whom the Software is furnished to do so, subject
% to the following conditions:
% The above copyright notice and this permission notice shall be included 
% in all copies or substantial portions of the Software.
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
% OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
% IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
% CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
% TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
% SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.