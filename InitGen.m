function M=InitGen(pop_size)
%%
%��ʼ��Ⱥѡȡ
%ѡȡʱ��֤��aw��bw��Լ������
global Sw;
global Swi;
global Sor;
global A;
A=(Sw-Swi)./(1-Swi-Sor);
global bwMax;
global boMax;
bwMax=10;
boMax=20;
bw=0+(bwMax-0).*rand([pop_size,1]);
for i=1:length(bw)
    Abw=A.^(-bw(i));
    MinAbw=min(Abw);
    aw(i)=0+(MinAbw-0).*rand([1,1]);
end
bo=0+(boMax-0).*rand([pop_size,1]);
M=[aw',bw,bo];
