function croToSle = oriCross( sleFromPop,croPro)
%UNTITLED Summary of this function goes here
% Crossover of original GA
[sleNum,col]=size(sleFromPop);
croToSle=sleFromPop;
for i=1:2:sleNum-mod(sleNum,2)
    a=rand();
    if a<=croPro
        rand1=randsrc(1,1,[2:col-1]);
        rand2=randsrc(1,1,[2:col-1]);
        if(rand1==rand2)
            croToSle(i,:)=sleFromPop(i,:);
            croToSle(i+1,:)=sleFromPop(i+1,:);
        end
        if(rand1~=rand2)
            cross1=sleFromPop(i,:);
            cross2=sleFromPop(i+1,:);
            s=min(rand1,rand2);
            e=max(rand1,rand2);
            for j=s:e
                cross1(j)=sleFromPop(i+1,j);
                cross2(j)=sleFromPop(i,j);
            end
            % cross1
            for j=2:col-1
                if(j<s||j>e)
                    cross1(j)=sleFromPop(i,j);
                    x=find(cross1==cross1(j));
                    x1=x(x~=j);
                    while(~isempty(x1))
                        cross1(j)=sleFromPop(i,x1);
                        x=find(cross1==cross1(j));
                        x1=x(x~=j);
                    end
                end
            end
             % cross2
             for j=2:col-1
                if(j<s||j>e)
                    cross2(j)=sleFromPop(i+1,j);
                    y=find(cross2==cross2(j));
                    y1=y(y~=j);
                    while(~isempty(y1))
                        cross2(j)=sleFromPop(i+1,y1);
                        y=find(cross2==cross2(j));
                        y1=y(y~=j);
                    end
                end
             end
             croToSle(i,:)=cross1;
             croToSle(i+1,:)=cross2;
        end
    end
end
end
