function   newPop = newPopulation( mutToCro,poplation)
%UNTITLED Summary of this function goes here
%  To create a new population, each individual in the new population is different

newPop=mutToCro;
newPopSize=size(newPop,1);
popSize=size(poplation,1);
for i=1:popSize
    for j=1:newPopSize
        if(comshuzu(poplation(i,:),newPop(j,:)))
            break;
        end
    end
    if(j==newPopSize)
        newPopSize=newPopSize+1;
        newPop(newPopSize,:)= poplation(i,:);
    end
end
end

