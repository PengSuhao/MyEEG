function [M_PLI] = pli(M)
%M是输入矩阵矩阵，维度为通道*时间系列
channel=size(M,1);
M_PLI=zeros(channel);

for x=1:channel
    for y=1:channel
                hilx=hilbert(M(x,:));  %x通道上的时间系列的希尔伯特变换
                hily=hilbert(M(y,:));  %y通道上的时间系列的希尔伯特变换
                tempx = angle(hilx);   %x通道上的瞬时相位角
                tempy = angle(hily);   %y通道上的瞬时相位角
                relative_phase = tempx - tempy;  %x,y两个电极瞬时相位角之差
             
%                PLIxy= abs(mean(sign((abs(relative_phase)- pi).*relative_phase)));
%                PLIxy= abs(mean(sign(relative_phase)));
                 PLIxy= abs(mean(sign(sin(relative_phase))));
                 
                M_PLI(x,y)=PLIxy; %x,y两电极之间的功能连接强度
    end
end
end
