function [data, fs, nbits] = new_wavread(filename, additional1, additional2)
% function to do something usefull (fill out)
% Usage y=new_wavread()
% Input Parameter:
%	 in_param: 		 Explain the parameter, default values, and units
% Output Parameter:
%	 out_param: 	 Explain the parameter, default values, and units
%------------------------------------------------------------------------ 
% Example: Provide example here if applicable (one or two lines) 

% Author: Nils L. Westhausen (c) TGM @ Jade Hochschule applied licence see EOF 
% Source: If the function is based on a scientific paper or a web site, 
%         provide the citation detail here (with equation no. if applicable)  
% Version History:
% Ver. 0.01 initial create (empty) 13-Apr-2015  Initials (eg. JB)

%------------Your function implementation here--------------------------- 



switch nargin
    case 2
        additional2 = [];

    case 1
        additional1 = [];
        additional2 = [];
end
if isempty(strfind(filename, '.wav'))
    filename = strcat(filename, '.wav');  
end
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