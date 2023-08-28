function  sleFromPop  = newSelect( mutToCro,sleFromPop,sleNum,gen,tar1,ptopdis1)
%UNTITLED Summary of this function goes here
% new selection operation

poplation=newPopulation( mutToCro,sleFromPop);
sleFromPop=poplation(1:sleNum,:);
popSize=size(poplation,1);
[fitDegDif,totalEngDif] = impFitness( tar1,poplation,ptopdis1 );   % fitness and energy comsumption calculation
[sortEng,sortEngNum] = sort(totalEngDif);
for b=1:sleNum
    sleFromPop(b,:)=poplation(sortEngNum(b),:);
end
k=100;
for c=sleNum+1:popSize
    r1=randsrc(1,1,1:sleNum);
    p=exp((totalEngDif(sortEngNum(r1))-sortEng(c))/(k/gen));
    r2=rand();
    if(r2<p)
        sleFromPop(r1,:)=poplation(sortEngNum(c),:);
    end
end
end

