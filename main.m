clear;
clc;
%����������Ϊ������������ʹ�ã����ﶨ��Ϊȫ�ֱ���
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
RHOo=0.9199;
MUo=140.1;
Bo=1.3;
RHOw=1.141;
MUw=1.5;
Bw=1;
Swi=0.25;
Sor=0.26;
N=528847;
load DATA;%ע�⣬DATA��һ��ΪSw���ڶ���Ϊfw
Sw=DATA(:,1);
fw=DATA(:,2);

%%
load DATA2; %��һ��Ϊ����Sw���ڶ���Ϊ������krw����3��Ϊ������kro
Sw_measure=DATA2(:,1);
Krw_measure=DATA2(:,2);
Kro_measure=DATA2(:,3);
%�Ŵ��㷨����
global max_gen;
pop_size=60;%��Ⱥ��С
lamda=0.75;%�����������棬����ĳ���Ϊ0.75�����轻��ǰ������Ϊa,b������bo��bw,�����a'=0.25a+0.75b,b'=0.75a+0.25b,����aw�������a'=a^0.25*b^0.75,b'=a^0.75*b^0.25
max_gen=3000; %������
pm=0.1;       %�������,���÷Ǿ��ȱ��죬�ұ��췶Χ������ʱ������ƽ���
pc=0.4;       %�������
Error=1e-6;   %ֹͣ�����
%%
%�Ŵ��㷨��ʼ��
%������ø��ӻ��ѡ���Ŵ��㷨��������Ⱥ�����У�
%�����ض��еĶ�ĸ��ִ�н��棬�����м���Ⱥ�������ض��е�ÿһ���м����ִ�б��죬�����Ӵ���Ⱥ��
%�ڸ�����Ⱥ���Ӵ���Ⱥ�Ĳ�����ѡ��ĸ����Ϊ��һ��������Ⱥ
%��ֹ����Ϊ��������������Ӧ�Ȳ�������
M=InitGen(pop_size);%������ʼ��Ⱥ
solution=[];
for i=1:max_gen
    %��Ⱥÿ�����������Ӧ��
    eval=[];
    for j=1:pop_size
        eval(j)=penalty(M(j,:));
    end
    %�������
    [M,eval]=CrossOperater(M,lamda,eval,pop_size,pc);
    %�������
    [M,eval]=VaryOperater(M,pm,eval,pop_size,i);
    %ѡ�����
    [M,eval]=SelectOperater(eval,M,pop_size);
    %�����Ĺ��ɣ�ÿһ��Ϊһ����Ⱥ����Ӧ�����ĸ��弰����Ӧ�ȣ���һ�б�ʾaw���ڶ��б�ʾbw�������б�ʾbo�������б�ʾ��Ӧ��
    solution=[solution;M(1,:),max(eval)];
    aw=solution(1);
    bw=solution(2);
    bo=solution(2);
    ao=1;
    %����Ⱥ��������300��������Ӧ�ȵ���300��ǰ����Ӧ�ȣ���ֹͣ����
    if(i>300)
        if(solution(end,4)-solution(end-299,4)<Error)
            break;
        end
    end
end
FinalSolution=solution(end,1:3);%���Ľ������˳��aw,bw,bo
%%
%����Ӧ������ͼ
plot(solution(:,end));
xlabel('��Ⱥ����');
ylabel('��Ӧ��ֵ');

%%
%�����ǰ���ͼ
aw=FinalSolution(1);
bw=FinalSolution(2);
bo=FinalSolution(3);
ao=1;
Krw=aw*((Sw-Swi)/(1-Swi-Sor)).^bw;
Kro=ao*((1-Sw-Sor)/(1-Swi-Sor)).^bo;
fw0=1./(1+RHOo*MUw*Bw/RHOw/MUo/Bo*Kro./Krw);
figure;
plot(Sw,fw);
hold on;
plot(Sw,fw0);
hold off;
xlabel('Sw');
ylabel('fw');
legend('ʵ��ֵ','����ֵ');

%%
figure;
Krw_cal=aw*((Sw_measure-Swi)/(1-Swi-Sor)).^bw;
Kro_cal=ao*((1-Sw_measure-Sor)/(1-Swi-Sor)).^bo;
plot(Sw_measure,Krw_cal,'^-r');
hold on;
plot(Sw_measure,Krw_measure,'^-g');
plot(Sw_measure,Kro_cal,'s-r');
plot(Sw_measure,Kro_measure,'s-g');
xlabel('��ˮ���Ͷ�');
xlim([0,1]);
ylabel('�����͸��');
ylim([0,1]);
legend('����ֵKrw','����ֵKrw','����ֵKro','����ֵKro');
hold off;
%%
figure;
plot(R,fw,'g');
hold on;
plot(R,fw0,'r');
hold off;
xlabel('������R');
ylabel('fw');
