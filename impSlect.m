function sleFromPopAfter = impSlect( sleFromPop,mutToCro,totalEng,totalEngAfterMut,gen )
% The selection operation in genetic algorithm is optimized using simulated annealing method
sleFromPopAfter=sleFromPop;
popSize=size(sleFromPop,1);
k=200;
for i=1:popSize
    if(totalEngAfterMut(i)<=totalEng(i))
        sleFromPopAfter(i,:)=mutToCro(i,:);
    else
        p=exp(totalEng(i)-totalEngAfterMut(i))/(k*gen);
        r1=rand();
        if(r1<p)
            sleFromPopAfter(i,:)=mutToCro(i,:);
        end
    end
end
end


