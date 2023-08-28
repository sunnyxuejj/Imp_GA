function  mutToCro  = oriMut( croToSle,mutPro)
%UNTITLED Summary of this function goes here
% Mutation operation in Original GA: 
% randomly select two points, switch their positions
% dynamically adjust the mutation operator
[sleNum,col]=size(croToSle);
mutToCro=croToSle;
for i=1:sleNum
    a=rand();
    if a<=mutPro
        rand1=randsrc(1,1,[2:col-1]);
        rand2=randsrc(1,1,[2:col-1]);
        if(rand1==rand2)
            mutToCro(i,:)=croToSle(i,:);
        else
            mutate1=croToSle(i,:);
            mutate1(rand1)=croToSle(i,rand2);
            mutate1(rand2)=croToSle(i,rand1);
            mutToCro(i,:)=mutate1;
        end
    end
end
end