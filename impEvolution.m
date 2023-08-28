function evoToPop =  impEvolution( tar1,poplation,ptopdis1)
%UNTITLED Summary of this function goes here
% evolutionary reversal of population 
    [popSiz,col]=size(poplation);
    evoToPop=poplation;
    for p=1:popSiz
        rand1=randsrc(1,1,[2:col-1]);
        rand2=randsrc(1,1,[2:col-1]);
        if(rand1~=rand2)
            evo1=evoToPop(p,:);
            s=min(rand1,rand2);
            e=max(rand1,rand2);
            q=0;
            while(q<=e-s)
                evo1(s+q)=poplation(p,e-q);
                q=q+1;
            end
            popSumDis=0;
            evo1SumDis=0;
            for j=1:col-1
                popSumDis=popSumDis+ptopdis1(poplation(p,j),poplation(p,j+1));
                evo1SumDis=evo1SumDis+ptopdis1(evo1(j),evo1(j+1));
            end
            popSumEng = comSumEng( tar1,poplation(p,:),popSumDis,ptopdis1);
            evo1SumEng = comSumEng( tar1,evo1,evo1SumDis,ptopdis1);
            if(popSumEng>evo1SumEng)
                evoToPop(p,:)=evo1;
                if(p>1)
                    for x=1:p-1
                        if(comshuzu( evoToPop(p,:),evoToPop(x,:) ))
                            evoToPop(p,:)=poplation(p,:);
                            break;
                        end
                    end
                end
            end
        end
    end
end

