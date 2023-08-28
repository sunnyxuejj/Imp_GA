function  mutToCro  = impMut( croToSle,sumDis )
%UNTITLED Summary of this function goes here
% Mutation operation in genetic algorithm: randomly select two points
% switch their positions, and dynamically adjust the mutation operator
[sleNum,col]=size(croToSle);
disNum=size(sumDis,1);
mutToCro=croToSle;
for i=1:sleNum
    
     % dynamically adjust the mutation operator
    minDis=min(sumDis);
    andDis=0;
    for z=1:disNum
        andDis=andDis+sumDis(z);
    end
    aveDis=andDis/disNum;
    k3=0.5;
    f2=sumDis(i);
    if(f2<=aveDis)
        mutPro=(k3*(f2-minDis))/(aveDis-minDis);
    else
        mutPro=k3;
    end
    
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
%            mutToCro(i,:)=mutate1;
            % If the altered individual is the same as the previous individual
            % the mutation operation is repeated until the altered individual is not the same as the previous individual
            if (i>1)
                for j=1:i-1
                    while(comshuzu(mutToCro(j,:),mutate1))
                        rand1=randsrc(1,1,[2:col-1]);
                        rand2=randsrc(1,1,[2:col-1]);
                        if(rand1==rand2)
                            mutToCro(i,:)=croToSle(i,:);
                        else
                            mutate1=croToSle(i,:);
                            mutate1(rand1)=croToSle(i,rand2);
                            mutate1(rand2)=croToSle(i,rand1);
                        end
                    end
                end
            end
            mutToCro(i,:)=mutate1;
        end
        
    end
end
end