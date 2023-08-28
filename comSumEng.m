function sumEng = comSumEng( tar1,poplation1,sumDis1,ptopdis)
%   According to the model, the energy consumed by distance, steering and information transmission is calculated respectively
col=size(poplation1,2);
tarNum=size(tar1,1);
sumAng=0;  %sumAng£¨1£©Represents the sum of the steering angles of a route

% energy consumed by distance
f=2;   % air drag
Ed=f*sumDis1;

a=5;  % energy factor of steering angles

p0=0.1;  % constan in energy consumed by data transmission
w=10*1024*1024; % transmitted data size in each target point
B=1024*1024; % bandwidth
p=zeros(tarNum-1,1);
c=zeros(tarNum-1,1);
namda=1; % constant ¦Ë in energy consumed by distance
N=50;  % Gaussian noise power
Et=zeros(tarNum-1,1);

% calculate the sum of the steering angles of a route
for j=2:col-1
    dotPro=(tar1(poplation1(j),1)-tar1(poplation1(j-1),1))*(tar1(poplation1(j+1),1)-tar1(poplation1(j),1))+(tar1(poplation1(j),2)-tar1(poplation1(j-1),2))*(tar1(poplation1(j+1),2)-tar1(poplation1(j),2));
    cos1=abs(dotPro/(ptopdis(poplation1(j-1),poplation1(j))*ptopdis(poplation1(j),poplation1(j+1))));
    ang=acos(cos1);
    sumAng=sumAng+ang;
end
% calculate the energy consumed by steering
Er=a*sumAng; 


% calculate the energy consumed by information transmission
totalEt=0;
for i=1:tarNum-1
    p(i)=p0*((tar1(i+1,1).^2+tar1(i+1,2).^2).^(namda/2));
    c(i)=B*log(1+p(i)/N)/log(2);
    Et(i)=w*p(i)/c(i);
    totalEt=totalEt+Et(i);
end

% toatl energy comsumption
sumEng=Ed+Er+totalEt;

end
    