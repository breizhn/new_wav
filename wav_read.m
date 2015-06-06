function [data, fs, nbits, opt] = wav_read(varargin)
%wav_read Read Microsoft WAVE (".wav") sound file.
%   It is a rewritten wavread() by using audioread.
%   This is a copy of the original documentation of wavread() from MATLAB.
%   Please note the struct opt which exits as ouptut in the wavread() 
%   function is not implemnted.
%   
% 
%   Y=wav_read(FILE) reads a WAVE file specified by the string FILE,
%   returning the sampled data in Y. The ".wav" extension is appended
%   if no extension is given.
%
%   [Y,FS,NBITS]=wav_read(FILE) returns the sample rate (FS) in Hertz
%   and the number of bits per sample (NBITS) used to encode the
%   data in the file.
%
%   [...]=wav_read(FILE,N) returns only the first N samples from each
%       channel in the file.
%   [...]=WAVREAD(FILE,[N1 N2]) returns only samples N1 through N2 from
%       each channel in the file.
%
%   [Y,...]=wav_read(...,FMT) specifies the data type format of Y used
%       to represent samples read from the file.
%       If FMT='double', Y contains double-precision normalized samples.
%       If FMT='native', Y contains samples in the native data type
%       found in the file.  Interpretation of FMT is case-insensitive,
%       and partial matching is supported.  If omitted, FMT='double'.
%
%   SIZ=wav_read(FILE,'size') returns the size of the audio data contained
%       in the file in place of the actual audio data, returning the
%       2-element vector SIZ=[samples channels].
%
%   ([Y,FS,NBITS,OPTS]=wav_read(...) returns a structure OPTS of additional
%       information contained in the WAV file.  The content of this
%       structure differs from file to file.  Typical structure fields
%       include '.fmt' (audio format information) and '.info' (text
%       which may describe title, author, etc.)
%       ) !!NOT IMPLEMENTED!!
%
%   Output Scaling
%   The range of values in Y depends on the data format FMT specified.
%   Some examples of output scaling based on typical bit-widths found
%   in a WAV file are given below for both 'double' and 'native' formats.
%   FMT='native'
%      #Bits   MATLAB data type          Data range
%      -----   ------------------------- -------------------
%        8     uint8  (unsigned integer)      0 <= Y <= 255
%       16     int16  (signed integer)   -32768 <= Y <= +32767
%       24     int32  (signed integer)    -2^23 <= Y <= 2^23-1
%       32     single (floating point)     -1.0 <= Y <= +1.0
%
%   FMT='double'
%      #Bits   MATLAB data type          Data range
%      -----   ------------------------- -------------------
%       N<32   double                     -1.0 <= Y <  +1.0
%       N=32   double                     -1.0 <= Y <= +1.0
%      Note: Values in y might exceed -1.0 or +1.0 for the case of
%            N=32 bit data samples stored in the WAV file.
%
%   Supports multi-channel data, with up to 32 bits per sample.
%   Supports Microsoft PCM data format only.

% Author: Nils L. Westhausen 
%        (c) TGM @ Jade Hochschule (MIT license).
%   
% Version History:
% Ver. 0.0.0 initial create (empty)     13-Apr-2015  NW
% Ver. 1.0.0 first implementation       19-Apr-2015  NW
% Ver. 1.1.0 new documentation          15-May-2015  NW
% Ver. 1.2.0 changed name to wav_read   28-May-2015  NW
% Ver. 1.3.0 changed input to varargin  04-Jun-2015  NW
%--------------------------------------------------------------------------

% return error if output opt exists
if nargout == 4
    warning('wav_read:no_opt', 'struct opt is not implemented')
    opt = struct;
end
% checks if .wav extension exists in filename and add it if not
if isempty(strfind(varargin{1}, '.wav'))
    varargin{1} = strcat(varargin{1}, '.wav');  
end

% creates nbits out of audioinfo
nbits = audioinfo(varargin{1});
nbits = nbits.BitsPerSample;

% using audioread for the diffrent possibilities of using wavread
if length(varargin) == 1
    [data, fs] = audioread(varargin{1});     
elseif (length(varargin) == 2) && isa(varargin{2}, 'char')
    if strcmp(varargin{2}, 'size')
        siz = audioinfo(varargin{1}); 
        data = [siz.TotalSamples siz.NumChannels];
        fs = siz.SampleRate;
    elseif strcmp(varargin{2}, 'native') || strcmp(varargin{2}, 'double')
        [data, fs] = audioread(varargin{1}, varargin{2});
    else
        error('wav_read:invalid_input','invalid input arguements')
    end
elseif  isa(varargin{2}, 'double') && (length(varargin{2}) <= 2) && ...
        not(isempty(varargin{2}))
    if length(varargin{2}) == 1 
        varargin{2} = [1 varargin{2}];
    end
    if length(varargin) == 2
        [data, fs] = audioread(varargin{1}, varargin{2});
    elseif length(varargin) == 3
        [data, fs] = audioread(varargin{1}, varargin{2}, varargin{3});
    else
        error('wav_read:invalid_input','invalid input arguements')
    end 
else
    error('wav_read:invalid_input','invalid input arguements')
end
end