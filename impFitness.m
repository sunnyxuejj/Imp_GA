function [fitDeg,totalEng] = impFitness( tar1,poplation,ptopdis )
%  fitness calcualtion of GA
[popSiz,pointNum]=size(poplation);
sumDis=zeros(popSiz,1);
for i=1:popSiz
    for j=1:pointNum-1
        sumDis(i)=sumDis(i)+ptopdis(poplation(i,j),poplation(i,j+1));
    end
end
totalEng = comTotalEng( tar1,poplation,sumDis,ptopdis);
fitDeg=(200*pointNum)./totalEng;
end

