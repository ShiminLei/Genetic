function val=penalty(ind)
%%
%��Ӧ�Ⱥ�����ΪĿ�꺯�����෴����Խ����Ӧ��Խ��
global RHOo;
global MUo;
global Bo;
global RHOw;
global MUw;
global Bw;
global Swi;
global Sor;
global N;
global Np;
global fw;
global Sw;
global R;
aw=ind(1);
bw=ind(2);
ao=1;
bo=ind(3);
%R=Np/N;
%Sw=R*(1-Swi)+Swi;
R=(Sw-Swi)/(1-Swi);
Krw=aw*((Sw-Swi)/(1-Swi-Sor)).^bw;
Kro=ao*((1-Sw-Sor)/(1-Swi-Sor)).^bo;
fw0=1./(1+RHOo*MUw*Bw/RHOw/MUo/Bo*Kro./Krw);
val=-(fw-fw0)'*(fw-fw0);

