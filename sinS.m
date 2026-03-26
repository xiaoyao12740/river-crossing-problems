function yorn=sinS(s, n)
yorn=1;
if s(1)<0 | s(1)>1 | s(2)<0 | s(2)>1 | s(3)<0 | s(3)>1 | s(4)<0 | s(4)>1
   yorn=0;
   return
end    
if s(1)~=s(2) & s(2)==s(3)
        yorn=0;
        return
end
if s(1)~=s(3) & s(3)==s(4)
        yorn=0;
        return
end
end