function [M_WPLI] = wpli(M)
%M是输入矩阵矩阵，维度为通道*时间系列
channel=size(M,1);
M_WPLI=zeros(channel);

for x=1:channel
    for y=1:channel
                hilx=hilbert(M(x,:));  %x通道上的时间系列的希尔伯特变换
                hily=hilbert(M(y,:));  %y通道上的时间系列的希尔伯特变换
                
%                 Lx=abs(hilx); %x通道上的时间系列的希尔伯特变换厚的瞬时辐値
%                 Ly=abs(hily); %y通道上的时间系列的希尔伯特变换厚的瞬时辐値
%                 
%                 tempx = angle(hilx);   %x通道上的瞬时相位角
%                 tempy = angle(hily);   %y通道上的瞬时相位角
%                 relative_phase = tempx - tempy;  %x,y两个电极瞬时相位角之差             
%                 S=Lx.*Ly.*sin(relative_phase);               
%                 WPLIxy= abs(sum(S))/sum(abs(S));
%                 M_WPLI(x,y)=WPLIxy; %x,y两电极之间的功能连接强度
                        
                crossspec = hilx.* conj(hily);
                crossspec_imag = imag(crossspec);
                
                WPLIxy= abs(mean(crossspec_imag))./mean(abs(crossspec_imag));
                M_WPLI(x,y)=WPLIxy; %x,y两电极之间的功能连接强度
                
                M_WPLI(isnan(M_WPLI)) = 0;
    end
end
end