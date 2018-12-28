clear;close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Author: Myoontyee.Chen
%% Data：20181227
%% License：BSD 3.0
%% CA - City Planning

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 图像预处理
I=imread('city.png');
level=graythresh(I);   % 图像灰度处理
bw=im2bw(I,level);  % 图像二值化处理
I=bw;
cells=double(I);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% button定义
plotbutton=uicontrol('style','pushbutton',...
'string','Run',...
'fontsize',12,...
'position',[100,400,50,20],...
'callback','runModel=1;');
erasebutton=uicontrol('style','pushbutton',...
'string','Stop',...
'fontsize',12,...
'position',[300,400,50,20],...
'callback','stopModel=1;');
Iterations=uicontrol('style','text',...
'string','1',...
'fontsize',12,...
'position',[20,400,50,20]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization参数初始化
cells(33,44)=2;
cells(88,31)=2;
cells(33,80)=2;

%% 可修改参数
diffuseFactor=0.2;          % 扩散因子
proliferateFactor=0.2;      % 繁殖因子
propagateFactor=0.2;        % 传播因子
Urbanization=0.0004;        % 城市化因子

%% 建议默认参数
sch=[];skz=[];t=1;
[x,y]=size(cells);
runModel=0;
stopModel=0;
stop=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 法则定义
while (stop==0)
    
    %% 按下Run
    if(runModel==1)
        for i=2:x-1
            for j=2:y-1
                if(cells(i,j)~=1)
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                  %% 自然增长
                    if(cells(i,j)==0) 
                        if(rand<Urbanization)
                        cells(i,j)=2;
                        end
                        if(aroundCenter(i,j,cells))
                            if(rand<propagateFactor)
                            cells(i,j)=2;
                            end
                        end
                    end
                
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                 %% 边界增长
                    if(cells(i,j)==2 && rand<diffuseFactor)  
                        if(existCase(i,j,cells))   
                        m=1+3*rand;
                            switch  m
                                case 1
                                    ii=i-1;jj=j;
                                case 2
                                    ii=i;jj=j-1;
                                case 3
                                    ii=i;jj=j+1;
                                otherwise 4
                                    ii=i+1;jj=j;
                            end
                            if(canCity(ii,jj,cells))  
                            cells(ii,jj)=2;
                            end
                        end
                    end
                
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              
                  %% 新扩展中心型
                    if(cells(i,j)==2 && existCase(i,j,cells))
                        if(rand<proliferateFactor)
                            if(canCity(i,j,cells))
                            cells(i,j)=3;
                            end
                        end
                    end
                
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                end
            end
        end

        ch=0;kzch=0;

        for i=1:x
            for j=1:y
                if(cells(i,j)==2) ch=ch+1;end
                if(cells(i,j)==3) kzch=kzch+1;end
            end
        end

        sch(t)=ch;skz(t)=kzch;
        t=t+1;

        [A,B]=size(cells);
        Area(1:A,1:B,1)=zeros(A,B);
        Area(1:A,1:B,2)=zeros(A,B);
        Area(1:A,1:B,3)=zeros(A,B);

        for i=1:A
            for j=1:B
                if cells(i,j)==1
                    Area(i,j,:)=[1,1,1]; % 黑色
                elseif cells(i,j)==0
                    Area(i,j,:)= [255, 255, 255]; % 白色
                elseif cells(i,j)==3
                    Area(i,j,:)= [255,0,0]; % 红色
                elseif cells(i,j)==2
                    Area(i,j,:)= [255,177,0]; % 橙色
                end
            end
        end

        pause(0.0005);
        Area=uint8(Area);
        imagesc(Area);
        axis equal;
        axis tight;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
       %% 迭代次数记录
        IterationNum=1+str2num(get(Iterations,'string'));
        set(Iterations,'string',num2str(IterationNum));
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% 按下Stop
    if stopModel==1
    runModel=0;
    stopModel=0;
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

%% 暂停并刷新图像
drawnow
end