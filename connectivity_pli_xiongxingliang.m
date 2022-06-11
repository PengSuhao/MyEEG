function [M_PLI] = pli(M)
%M������������ά��Ϊͨ��*ʱ��ϵ��
channel=size(M,1);
M_PLI=zeros(channel);

for x=1:channel
    for y=1:channel
                hilx=hilbert(M(x,:));  %xͨ���ϵ�ʱ��ϵ�е�ϣ�����ر任
                hily=hilbert(M(y,:));  %yͨ���ϵ�ʱ��ϵ�е�ϣ�����ر任
                tempx = angle(hilx);   %xͨ���ϵ�˲ʱ��λ��
                tempy = angle(hily);   %yͨ���ϵ�˲ʱ��λ��
                relative_phase = tempx - tempy;  %x,y�����缫˲ʱ��λ��֮��
             
%                PLIxy= abs(mean(sign((abs(relative_phase)- pi).*relative_phase)));
%                PLIxy= abs(mean(sign(relative_phase)));
                 PLIxy= abs(mean(sign(sin(relative_phase))));
                 
                M_PLI(x,y)=PLIxy; %x,y���缫֮��Ĺ�������ǿ��
    end
end
end
