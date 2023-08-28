function  sleFromPop  = select( poplation,sleNum,fitDeg)
%UNTITLED Summary of this function goes here
% selection of original GA

sumFitDeg=0;
[popSiz,col]=size(poplation);
sumFitRatio=zeros(popSiz,1);
sleFromPop=zeros(sleNum,col);
for i=1:popSiz
    sumFitDeg=sumFitDeg+fitDeg(i);
end
for i=1:popSiz
    for j=1:i
        sumFitRatio(i)=sumFitRatio(i)+fitDeg(j)/sumFitDeg;
    end
end
k=1;
while(k<=sleNum)
    a=rand();
    if(a<sumFitRatio(1))
        sleFromPop(k,:)=poplation(1,:);
        k=k+1;
        continue;
    end
    for z=2:popSiz
        if(a>sumFitRatio(z-1)&&a<sumFitRatio(z))
            sleFromPop(k,:)=poplation(z,:);
            k=k+1;
            break;
        end
    end
    if k>2
        for j=1:k-2
            if(comshuzu( sleFromPop(j,:),sleFromPop(k-1,:) ))
                k=k-1;
                break;
            end
        end
    end     
end

