n=1; % 人猫鸡米各自的个数
begin=[n;n;n;n];
s=begin;
k=1;
d_int=1;
s_result=s;
d_result=[];
D=[1 1 1 1;0 1 0 0;0 0 1 0;0 0 0 1];
L_D=size(D,2);
exist_result=1;

while any(s~=[0;0;0;0])
    while d_int<=L_D
        d=D(:,d_int);
        s_mid=s+(-1)^k*d;
        if sinS(s_mid,n)   %当前的s_mid在S中
            s_mid_int=find(sum(s_mid*ones(1,k)==s_result,1)==4);
            if isempty(s_mid_int) || length(s_mid_int)==1
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
        if all(s==begin) && mod(k,2)==1
            disp('该问题无解!');
            exist_result=0;
            break;
        end
        s=s_result(:,end-1);
        s_result(:,end)=[];
        k=k-1;
        d_int=find(sum(d_result(:,k)*ones(1,L_D)==D,1)==2);
        d_result(:,end)=[];
        d_int=d_int+1;
    end
end

if exist_result==1
    C=size(s_result,2)-1;
    disp('s_result:');
    disp(s_result);
    fprintf('一共渡河的次数为%d\n',C)
end

function yorn=sinS(s, n)
yorn=1;
if any(s<0) || any(s>1)
   yorn=0;
   return
end    
if s(1)~=s(2) && s(2)==s(3)
    yorn=0;
    return
end
if s(1)~=s(3) && s(3)==s(4)
    yorn=0;
    return
end
end
