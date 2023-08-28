function isequ = comshuzu( a,b )
% Compares all elements in two arrays to see if they are the same
% and returns 1 if they are the same
 num1=size(a,2);
 equNum=0;
 for i=1:num1
     if a(i)==b(i)
         equNum=equNum+1;
     end
 end
 if equNum==num1
     isequ=1;
 else
     isequ=0;
end

