function new_wavwrite(data,fs,additional1,additional2)
% alternative to wavwrite command with same syntax by using audiowrite
% Usage new_wavwrite(data, fs, filename/nbits, filename)
% Input Parameter:
%	data:           audio data vector
%   fs:             sampling rate (double)
%   additional1:    if 3 inputs it is the filename (string)
%                   if 4 inputs it is bits per sample (double)
%   additional2:    the filname by 4 inputs
% 
%------------------------------------------------------------------------  

% Author: Nils L. Westhausen (c) TGM @ Jade Hochschule applied licence see EOF 
% 
% Version History:
% Ver. 0.01 initial create (empty) 13-Apr-2015  NW
% Ver. 0.80 first implemntation    10-Apr-2015  NW

%-------------------------------------------------------------------------- 
switch nargin
    case 1
        error('myApp:argChk', 'not enough input arguments')
    case 2
        error('myApp:argChk', 'It is sampling-rate needed for writing wav-file')
    case 3
        additional2 = [];
        % checks if .wav extension exists in filename and add it if not
        if isempty(strfind(additional1, '.wav'))
            additional1 = strcat(additional1, '.wav'); 
        end
        % use of audiowrite
        audiowrite(additional1, data ,fs)
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