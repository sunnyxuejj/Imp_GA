function [fitDeg,sunDis] = fitness( poplation,ptopdis )
% fitness calculation in original GA
[popSiz,pointNum]=size(poplation);
sunDis=zeros(popSiz,1);
for i=1:popSiz
    for j=1:pointNum-1
        sunDis(i)=sunDis(i)+ptopdis(poplation(i,j),poplation(i,j+1));
    end
end
fitDeg=(200*pointNum)./sunDis;
end