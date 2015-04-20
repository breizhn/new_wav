function new_wavwrite(data,fs,additional1,additional2)
% function to do something usefull (fill out)
% Usage new_wavwrite(data,fs,additional1,additional2)
% Input Parameter:
%	 in_param: 		 Explain the parameter, default values, and units
% 
%------------------------------------------------------------------------ 
% Example: Provide example here if applicable (one or two lines) 

% Author: Nils L. Westhausen (c) TGM @ Jade Hochschule applied licence see EOF 
% Source: If the function is based on a scientific paper or a web site, 
%         provide the citation detail here (with equation no. if applicable)  
% Version History:
% Ver. 0.01 initial create (empty) 13-Apr-2015  Initials (eg. JB)

%------------Your function implementation here--------------------------- 
switch nargin
    case 1
        error('myApp:argChk', 'not enough input arguments')
    case 2
        error('myApp:argChk', 'It is fs needed for writing wav-file')
    case 3
        additional2 = [];
        if isempty(strfind(additional1, '.wav'))
            additional1 = strcat(additional1, '.wav'); 
        end
        audiowrite(additional1,data,fs)
    case 4
        if isempty(strfind(additional2, '.wav'))
            additional2 = strcat(additional2, '.wav'); 
        end
        audiowrite(additional2,data,fs,'BitsPerSample',additional1) 
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