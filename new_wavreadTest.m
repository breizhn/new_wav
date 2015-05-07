% Script to test and compare the function new_wavread.m with the "old"
% Author: Nils L. Westhausen (c) TGM @ Jade Hochschule applied licence see EOF 
% Version History:
% Ver. 0.01 initial create (empty) 13-Apr-2015 			 NW
% Ver. 0.08 First Implementation   06-May-2015           NW

audiowrite('test_audio.wav', randn(1,96000).*0.1, 48000)
%-------------------------------------------------------------------------
%% Testing error returning with four output arguements
try
    [y, fs, nbits, opt] = new_wavread('test_audio.wav');
    
catch err
    switch err.identifier
        case 'myApp:INargChk'
            
        otherwise
            error('not returning error, when called with four output arguements')
    end
end
%% equality of the old and the new; out:[y,fs,nbits] in: filename
[y_new, fs_new, nbits_new] = new_wavread('test_audio');
[y_old, fs_old, nbits_old] = wavread('test_audio');

if any(find(abs(y_old - y_new)> 0.01))
    error('the data is not equal')
end

if fs_old ~= fs_new
    error('the sampling rate is not the same')
end

if nbits_old ~= nbits_new
    error('The bits per sample are not equal')
end
%% equality of the old and the new; out:[y,fs] in: filename, 'size'

[siz_new, fs_new] = new_wavread('test_audio','size');
[siz_old, fs_old] = wavread('test_audio','size');

if siz_old ~= siz_new
    error('the size struct is not equal')
end

if fs_old ~= fs_new
    error('the sampling rate is not the same')
end

%% equality of the old and the new; out:[y] in: filename, sample

[y_new] = new_wavread('test_audio',800);
[y_old] = wavread('test_audio',800);

if length(y_new) ~= length(y_old)
    error('the length of the data is not equal')
end

if any(find(abs(y_old - y_new)> 0.01))
    error('the data is not equal')
end

%% equality of the old and the new; out:[y] in: filename, [N1 N2]
[y_new] = new_wavread('test_audio',[800 60000]);
[y_old] = wavread('test_audio',[800 60000]);

if length(y_new) ~= length(y_old)
    error('the length of the data is not equal')
end

if any(find(abs(y_old - y_new)> 0.01))
    error('the data is not equal')
end

%% equality of the old and the new; out:[y] in: filename, 'native'
[y_new] = new_wavread('test_audio','native');
[y_old] = wavread('test_audio','native');

if any(find(abs(y_old - y_new)> 0.01))
    error('the data is not equal')
end
%% equality of the old and the new; out:[y] in: filename, 'double'
[y_new] = new_wavread('test_audio','double');
[y_old] = wavread('test_audio','double');

if any(find(abs(y_old - y_new)> 0.01))
    error('the data is not equal')
end
%%
delete('test_audio.wav')
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