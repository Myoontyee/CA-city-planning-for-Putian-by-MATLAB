function result=canCity(i,j,cells)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Author: Myoontyee.Chen
%% Data£º20181227
%% License£ºBSD 3.0
%% canCity - Correspondence rule

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=0
if(cells(i-1,j-1)==1)   s=s+1;end
if(cells(i-1,j)==1)     s=s+1;end
if(cells(i-1,j+1)==1)   s=s+1;end
if(cells(i,j-1)==1)     s=s+1;end
if(cells(i,j+1)==1)     s=s+1;end
if(cells(i+1,j-1)==1)   s=s+1;end
if(cells(i+1,j)==1)     s=s+1;end
if(cells(i+1,j+1)==1)   s=s+1;end
if(s>=4)
    result=0;
else 
    result=1;
end
end
