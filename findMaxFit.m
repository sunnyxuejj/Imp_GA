function [ minEng,maxFitDeg,maxFitPath ] = findMaxFit( fitDeg,poplation,totalEng )
%  Search for the individual with minial energy comsumption and
%  correspending minimal energy comsumption
popSiz = size(poplation,1);
minEng=totalEng(1);
maxFitPath=poplation(1,:);
maxFitDeg=fitDeg(1);
for i=2:popSiz
    if(totalEng(i)<minEng)
        maxFitDeg=fitDeg(i);
        maxFitPath=poplation(i,:);
        minEng=totalEng(i);
    end
end
end

