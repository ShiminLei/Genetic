function [M,eval]=CrossOperater(M1,lamda,eval1,pop_size,pc)
%%
%��������
%������ѡȡһ���ĸ������н���
rand1=rand(1,pop_size)<pc;
%ordinalΪѡȡ�Ľ���ĸ�������
ordinal=find(rand1);
%numΪĸ���ĸ���
num=length(ordinal);
M=M1;
eval=eval1;
if num~=0 && num~=1 %����С��2���򲻽��棬���򽻲�
    if mod(num,2)==0  %����Ϊż������ȫ����������
        for j=0:num/2-1
            ind1=M(ordinal(j*2+1),:);
            ind2=M(ordinal(j*2+2),:);
            [ind3,ind4]=cross(ind1,ind2,lamda);
            eval3=penalty(ind3);
            eval4=penalty(ind4);
            eval=[eval,eval3,eval4];
            M=[M;ind3;ind4];
        end
    else
        for j=1:(num-1)/2  %����Ϊ��������ǰn-1����������
            ind1=M(ordinal(j*2-1),:);
            ind2=M(ordinal(j*2),:);
            [ind3,ind4]=cross(ind1,ind2,lamda);
            eval3=penalty(ind3);
            eval4=penalty(ind4);
            eval=[eval,eval3,eval4];
            M=[M;ind3;ind4];
        end
    end
end