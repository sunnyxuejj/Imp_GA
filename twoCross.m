function [ cross1,cross2 ] = twoCross( rand1,rand2,sleFromPop1,sleFromPop2,col )
%UNTITLED Summary of this function goes here
%  the crossover operation between two individuals in original GA

if(rand1==rand2)
    cross1=sleFromPop1;
    cross2=sleFromPop2;
end
if(rand1~=rand2)
    cross1=sleFromPop1;
    cross2=sleFromPop2;
    s=min(rand1,rand2);
    e=max(rand1,rand2);
    for j=s:e
        cross1(j)=sleFromPop2(j);
        cross2(j)=sleFromPop1(j);
    end
    %计算子代1，为cross1
    for j=2:col-1
        if(j<s||j>e)
            cross1(j)=sleFromPop1(j);
            x=find(cross1==cross1(j));
            x1=x(x~=j);
            while(~isempty(x1))
                cross1(j)=sleFromPop1(x1);
                x=find(cross1==cross1(j));
                x1=x(x~=j);
            end
        end
    end
    %计算子代2，为cross2
    for j=2:col-1
        if(j<s||j>e)
            cross2(j)=sleFromPop2(j);
            y=find(cross2==cross2(j));
            y1=y(y~=j);
            while(~isempty(y1))
                cross2(j)=sleFromPop2(y1);
                y=find(cross2==cross2(j));
                y1=y(y~=j);
            end
        end
    end
end
end

