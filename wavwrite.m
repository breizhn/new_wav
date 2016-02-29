function wavwrite(varargin)
%wavwrite Write Microsoft WAVE (".wav") sound file.
%   It is a rewritten wavwrite() by using audiowrite.
%   This is a copy of the original documentation of wavrwrite() from MATLAB.
%   
%
%   wavwrite(Y,FS,NBITS,WAVEFILE) writes data Y to a Windows WAVE
%   file specified by the file name WAVEFILE, with a sample rate
%   of FS Hz and with NBITS number of bits.  NBITS must be 8, 16,
%   24, or 32.  Stereo data should be specified as a matrix with two
%   columns.
%
%   wavwrite(Y,FS,WAVEFILE) assumes NBITS=16 bits.
%   wavwrite(Y,WAVEFILE) assumes NBITS=16 bits and FS=8000 Hz.
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
% Usage wavwrite(data, fs, filename/nbits, filename)
% 
%------------------------------------------------------------------------  

% Author: Nils L. Westhausen 
%         (c) TGM @ Jade Hochschule (MIT license).
% 
% Version History:
% Ver. 0.0.0 initial create (empty)     13-Apr-2015  NW
% Ver. 1.0.0 first implementation        10-Apr-2015  NW
% Ver. 1.1.0 input without fs           15-May-2015  NW
% Ver. 1.2.0 new/old documentation      15-May-2015  NW
% Ver. 1.3.0 changed name to wavwrite  28-May-2015  NW
% Ver. 1.4.0 changed input to varargin  03-Jun-2015  NW
% Ver. 1.5.0 changed name of the function to wavwrite 29-Feb-2016 NW
%-------------------------------------------------------------------------- 
switch nargin
    case 2
        filename = check_wav_extension(varargin{2});
        % use of audiowrite
        audiowrite(filename, varargin{1}, 8000, 'BitsPerSample', 16)
    case 3
        % checks if .wav extension exists in filename and add it if not
        filename = check_wav_extension(varargin{3});
        % use of audiowrite
        audiowrite(filename, varargin{1}, varargin{2}, 'BitsPerSample', 16)
    case 4
        % checks if .wav extension exists in filename and add it if not
        filename = check_wav_extension(varargin{4});
        % use of audiowrite
        audiowrite(filename, varargin{1}, varargin{2}, 'BitsPerSample',...
            varargin{3}) 
    otherwise
        error('wavwrite:notEnoughArgs', ...
            'invalid number of input arguments')
end
% function to check for .wav extension, and add it if needed
function  [filename_wav] = check_wav_extension(filename)
    if isempty(strfind(filename, '.wav'))
        filename_wav = strcat(filename, '.wav'); 
    else
        filename_wav = filename; 
    end
end
end