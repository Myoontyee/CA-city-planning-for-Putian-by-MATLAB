function a=aroundCenter(i,j,cells)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Author: Myoontyee.Chen
%% Data��20181227
%% License��BSD 3.0
%% aroundCenter - Correspondence rule

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=0;
if(cells(i-1,j)==3)  a=1; end
if(cells(i,j-1)==3)  a=1;end
if(cells(i,j+1)==3)  a=1;end
if(cells(i+1,j)==3)  a=1;end
end
