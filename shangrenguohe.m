n=3; %商人数及随从数
begin=[n;n];s=begin;k=1;d_int=1;s_result=s;d_result=[];
D=[0 0 1 1 2;1 2 0 1 0]; 
%小船可以坐2人的允许决策集%D=[00011223;12301010];
%船上至多坐3人的允许决策集%%D=[0011203204;1201030240];
L_D=size(D,2);
exist_result=1;
while any(s~=[0;0])%%step4中的判定%%step2-1中的判定
    while d_int<=L_D
        d=D(:,d_int);
        s_mid=s+(-1)^k*d;
        if sinS(s_mid,n)   %当前的s_mid在S中
            s_mid_int=find(sum(s_mid*ones(1,k)==s_result,1)==2);
            %%s_mid在s_result的位置，记录为s_mid_int,可能为空
            %如果s result中存在s_mid,且位置和k+1具备相同的奇偶性
            %则说明存在状态循环问题，此s_mid不适合作为求解状态
            if length(s_mid_int)~=2 &&...
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
    disp('s_result:');
    disp(s_result);
    figure;hold on;
    axis([-.5,n+0.5,-.5,n+0.5]);
    axis equal;
    r=0.1;sita=0:pi/10:2*pi;
%绘制允许状态集合
for x=0:n
    for y=0:n
        if sinS([x,y],n)
            X=x+r*cos(sita);Y=y+r*sin(sita);
            fill(X,Y,'b')
        end
    end
end
%绘制状态的转移过程
X_P=begin(1)+r*cos(sita);Y_P=begin(2)+r*sin(sita);
h=fill(X_P,Y_P,'r');
gap_NUM=20; %每两个点之间的分割段数
for kn=1:size(s_result,2)-1
    B_P=s_result(:,kn);E_P=s_result(:,kn+1);
    R_X_mid=linspace(B_P(1),E_P(1),gap_NUM+1);
    R_Y_mid=linspace(B_P(2),E_P(2),gap_NUM+1);
    for k_mid=1:length(R_X_mid)
        X_mid=R_X_mid(k_mid)+r*cos(sita);
        Y_mid=R_Y_mid(k_mid)+r*sin(sita);
        pause(0.1);
        set(h,'xdata',X_mid)
        set(h,'ydata',Y_mid)
    end
end
end
function yorn=sinS(s, n)
yorn=1;
if s(1)<0 | s(1)>3 | s(2)<0 | s(2)>3
   yorn=0;
   return
end    
if s(1)~=0 & s(2)>s(1)
   yorn=0;
   return
end
if s(1)~=3 & s(1)>s(2)
   yorn=0;
   return
end
end