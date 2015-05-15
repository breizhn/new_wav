function new_wavwrite(data,fs,additional1,additional2)
%new_wavwrite Write Microsoft WAVE (".wav") sound file.
%   alternative to wavwrite command with same syntax by using audiowrite.
%   This is the documentation of the original wavwrite().
%
%   new_wavwrite(Y,FS,NBITS,WAVEFILE) writes data Y to a Windows WAVE
%   file specified by the file name WAVEFILE, with a sample rate
%   of FS Hz and with NBITS number of bits.  NBITS must be 8, 16,
%   24, or 32.  Stereo data should be specified as a matrix with two
%   columns.
%
%   new_wavwrite(Y,FS,WAVEFILE) assumes NBITS=16 bits.
%   new_wavwrite(Y,WAVEFILE) assumes NBITS=16 bits and FS=8000 Hz.
%
%   Input Data Ranges
%   The range of values in Y depends on the number of bits specified by NBITS 
%   and the data type of Y.  Some examples of valid input ranges based on the 
%   value of NBITS and Y's data type are listed in the tables below.
%
%   If Y contains integer data:
%
%       NBITS   Y's data type    Y's Data range          Output Format
%      -------  ---------------- ---------------------   -------------
%         8         uint8             0 <= Y <= 255         uint8
%        16         int16        -32768 <= Y <= +32767      int16 
%        24         int32         -2^23 <= Y <= 2^23-1      int32
%
%   If Y contains floating point data:
%
%       NBITS   Y's data type    Y's Data range          Output Format
%      -------  ---------------- ---------------------   -------------
%         8     single or double   -1.0 <= Y <  +1.0        uint8
%        16     single or double   -1.0 <= Y <  +1.0        int16
%        24     single or double   -1.0 <= Y <  +1.0        int32
%        32     single or double   -1.0 <= Y <= +1.0        single
%
%   Note that for floating point data where NBITS < 32, amplitude values 
%   are clipped to the range -1.0 <= Y < +1.0.
%
%   8-, 16-, and 24-bit files are type 1 integer PCM.
%   32-bit files are written as type 3 normalized floating point.

% alternative to wavwrite command with same syntax by using audiowrite
% Usage new_wavwrite(data, fs, filename/nbits, filename)
% It can't used without fs unlike the "old" wavwrite.
% Input Parameter:
%	data:           audio data vector
%   fs:             sampling rate (double)
%   additional1:    if 3 inputs it is the filename (string)
%                   if 4 inputs it is bits per sample (double)
%   additional2:    the filname by 4 inputs
% 
%------------------------------------------------------------------------  

% Author: Nils L. Westhausen 
%         (c) TGM @ Jade Hochschule applied licence see LICENCE file.
% 
% Version History:
% Ver. 0.0.0 initial create (empty) 13-Apr-2015  NW
% Ver. 1.0.0 first implemntation    10-Apr-2015  NW
% Ver. 1.1.0 input without fs       15-May-2015  NW
% Ver. 1.2.0 new/old documentation  15-May-2015  NW
%-------------------------------------------------------------------------- 
switch nargin
    case 1
        error('new_wavwrite:notEnoughArgs', 'not enough input arguments')
    case 2
        additional2 = [];
        additional1 = [];
        if isempty(strfind(fs, '.wav'))
            fs = strcat(fs, '.wav'); 
        end
        % use of audiowrite
        audiowrite(fs, data ,8000, 'BitsPerSample', 16)
    case 3
        additional2 = [];
        % checks if .wav extension exists in filename and add it if not
        if isempty(strfind(additional1, '.wav'))
            additional1 = strcat(additional1, '.wav'); 
        end
        % use of audiowrite
        audiowrite(additional1, data ,fs, 'BitsPerSample', 16)
    case 4
        if isempty(strfind(additional2, '.wav'))
            additional2 = strcat(additional2, '.wav'); 
        end
        audiowrite(additional2, data, fs, 'BitsPerSample', additional1) 
end

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