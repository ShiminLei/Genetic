function M1=vary(M,t,T)
%���ܣ����캯����MΪ����������tΪ���������TΪ�ܵĴ�����
%����ʱ�����������С�ı��췽�����ұ������Ȼ����Լ������
global bwMax;
global boMax;
global A;
r1=rand();
r2=randi([0,1],1,1);
aw=M(1);
bw=M(2);
bo=M(3);
%��r2Ϊ0������󴦱��죬����֤���������ֵ����r2Ϊ1����С�����죬����֤��С��0
if(r2==0)
    bw1=bw+(bwMax-bw)*r1*(1-t/T)^2;
elseif(r2==1)
    bw1=bw-bw*r1*(1-t/T)^2;
end
r1=rand();
r2=randi([0,1],1,1);
%��r2Ϊ0������󴦱��죬����֤���������ֵ����r2Ϊ1����С�����죬����֤��С��0
if(r2==0)
    bo1=bo+(boMax-bo)*r1*(1-t/T)^2;
elseif(r2==1)
    bo1=bo-bo*r1*(1-t/T)^2;
end
r1=rand();
r2=randi([0,1],1,1);
Abw=A.^(-bw1);
MinAbw=min(Abw);
%��r2Ϊ0������󴦱��죬����֤���������ֵ����r2Ϊ1����С�����죬����֤��С��0
if(r2==0)
    aw1=aw+(MinAbw-aw)*r1*(1-t/T)^2;
elseif(r2==1)
    aw1=aw-aw*r1*(1-t/T)^2;
end
M1=[aw1,bw1,bo1];