function result= existCase(i,j,cells)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Author: Myoontyee.Chen
%% Data��20181227
%% License��BSD 3.0
%% existCase - Correspondence rule

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=0;
if(cells(i-1,j)==2)  a=a+1; end
if(cells(i,j-1)==2)  a=a+1;end
if(cells(i,j+1)==2)  a=a+1;end
if(cells(i+1,j)==2)  a=a+1;end
if(a>=2)
    result=1;
else
    result=0;
end
end
