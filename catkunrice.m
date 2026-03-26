n=1; %人猫鸡米各自的个数
begin=[n;n;n;n];s=begin;k=1;d_int=1;%选取决策位置
s_result=s;
d_result=[];%存储决策结果
D=[1 1 1 1;0 1 0 0;0 0 1 0;0 0 0 1]; %允许决策集
L_D=size(D,2);
exist_result=1;
while any(s~=[0;0;0;0])%%step4中的判定%%step2-1中的判定
    while d_int<=L_D
        d=D(:,d_int);
        s_mid=s+(-1)^k*d;
        if sinS(s_mid,n)   %当前的s_mid在S中
            s_mid_int=find(sum(s_mid*ones(1,k)==s_result,1)==4);
            if length(s_mid_int)~=4 &&...
                    (length(s_mid_int)==0||mod(k+1-s_mid_int,2)==1)
                s=s_mid;
                s_result=[s_result,s];
                d_result=[d_result,d];
                k=k+1;
                d_int=1;
                break;
            end
        end
        d_int=d_int+1;
    end
    if d_int>L_D
        if all(s==begin)
            disp('该问题无解!');
            exist_result=0;
            %%%需要给出一个无解的标记!
        break;
        end
        s=s_result(:,end-1);
        s_result(:,end)=[];
        %删除s_result的最后一列
        %d_int记为d_result(k)在D中的位置
        k=k-1;
        d_int=find(sum(d_result(:,k)*ones(1,L_D)==D,1)==2);
        d_result(:,end)=[];
        d_int=d_int+1;
    end
end
%%%如果问题存在解，即exist_result=1时，输出结果。
if exist_result==1
    C=size(s_result,2)-1;
    disp('s_result:');
    disp(s_result);
    fprintf('一共渡河的次数为%d\n',C)
end