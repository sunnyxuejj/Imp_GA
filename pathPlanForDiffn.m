pointNum=5:12;
num=size(pointNum,2);
minEngEnd=zeros(num,1);
minEngOriEnd=zeros(num,1);
 for n=1:num
     [minEngEnd(n),minEngOriEnd(n)] = diff_n(pointNum(n) );
 end
 
 
 % Plot the relationship between target points and minimum energy
figure(1);
ylabel('minimum energy');
xlabel('number of target points');
plot(pointNum,minEngEnd,'r-');
hold on;
plot(pointNum,minEngOriEnd);
grid on;
legend("Our improved GA","Original GA");
title('minimum energy versus target points');
