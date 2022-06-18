function [M_WPLI] = wpli(M)
%M������������ά��Ϊͨ��*ʱ��ϵ��
channel=size(M,1);
M_WPLI=zeros(channel);

for x=1:channel
    for y=1:channel
                hilx=hilbert(M(x,:));  %xͨ���ϵ�ʱ��ϵ�е�ϣ�����ر任
                hily=hilbert(M(y,:));  %yͨ���ϵ�ʱ��ϵ�е�ϣ�����ر任
                
%                 Lx=abs(hilx); %xͨ���ϵ�ʱ��ϵ�е�ϣ�����ر任���˲ʱ����
%                 Ly=abs(hily); %yͨ���ϵ�ʱ��ϵ�е�ϣ�����ر任���˲ʱ����
%                 
%                 tempx = angle(hilx);   %xͨ���ϵ�˲ʱ��λ��
%                 tempy = angle(hily);   %yͨ���ϵ�˲ʱ��λ��
%                 relative_phase = tempx - tempy;  %x,y�����缫˲ʱ��λ��֮��             
%                 S=Lx.*Ly.*sin(relative_phase);               
%                 WPLIxy= abs(sum(S))/sum(abs(S));
%                 M_WPLI(x,y)=WPLIxy; %x,y���缫֮��Ĺ�������ǿ��
                        
                crossspec = hilx.* conj(hily);
                crossspec_imag = imag(crossspec);
                
                WPLIxy= abs(mean(crossspec_imag))./mean(abs(crossspec_imag));
                M_WPLI(x,y)=WPLIxy; %x,y���缫֮��Ĺ�������ǿ��
                
                M_WPLI(isnan(M_WPLI)) = 0;
    end
end
end