function [data, fs, nbits, opt] = new_wavread(filename, additional1, additional2)
% function to to be used like wavread() with same sytax using audioread and
% audioinfo instead of the origanal wavread(). Please note the struct opt 
% which exits as ouptut in the wavread() function is not implemnted.

% Usage [data, fs, nbits] = new_wavread(filename, additional1, additional2)
% Input Parameter:
%   filename:       name of the file you want to read (string)
%   additional1:    the additinal arguments can stand for some things, 
%   additional2:    please read the wavread() documentation for futher 
%                   information
% Output Parameter:
%   data:           vector of audiodata of the wav-file
%   fs:             sampling frequencie (double) of the wav-file
%   nbits:          pits per sample (double) of the wav-file
%   opt:            returns an error if wnated
%------------------------------------------------------------------------ 

% Author: Nils L. Westhausen (c) TGM @ Jade Hochschule applied licence see EOF 
%   
% Version History:
% Ver. 0.01 initial create (empty) 13-Apr-2015  NW
% Ver. 0.80 first implementation   19-Apr-2015  NW

%--------------------------------------------------------------------------

% return error if output opt exists
if nargout==4
    error('myApp:argChk', 'struct opt is not implemented')
end

% sets the not inserted arguments to an empty array
switch nargin
    case 2
        additional2 = [];

    case 1
        additional1 = [];
        additional2 = [];
end

% checks if .wav extension exists in filename and add it if not
if isempty(strfind(filename, '.wav'))
    filename = strcat(filename, '.wav');  
end

% creates nbits out of audioinfo
nbits = audioinfo(filename);
nbits = nbits.BitsPerSample;


if isempty(additional1) && isempty(additional2)
    [data, fs] = audioread(filename);
       
end  
  
if isempty(additional2) && isa(additional1, 'char')
    
    if strcmp(additional1, 'size')
       siz = audioinfo(filename); 
       data = [siz.TotalSamples siz.NumChannels];
       fs = siz.SampleRate;
       
    end
    
    
    if strcmp(additional1, 'native') || strcmp(additional1, 'double')
        [data, fs]=audioread(filename, additional1);
        
        
    end
end
if  isa(additional1,'double') && (length(additional1)<=2)
    
    if length(additional1)==1 
        additional1=[1 additional1];
    end
    if isempty(additional2)
        [data, fs]=audioread(filename,additional1);
    else
        [data, fs]=audioread(filename,additional1,additional2);
    end
    
end
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