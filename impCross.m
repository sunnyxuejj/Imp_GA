function croToSle = impCross( sleFromPop,sumDis)
%UNTITLED Summary of this function goes here
% selection operation of GA
% partial mapping cross
% dynamically adjust the crossover operator
[sleNum,col]=size(sleFromPop);
disNum=size(sumDis,1);
croToSle=sleFromPop;
for i=1:2:sleNum-mod(sleNum,2)

    % dynamically adjust the crossover operator
    minDis=min(sumDis);
    andDis=0;
    for z=1:disNum
        andDis=andDis+sumDis(z);
    end
    aveDis=andDis/disNum;
    k1=0.9;k2=0.8;
    f1=min(sumDis(i),sumDis(i+1));
    if(f1<=aveDis)
        croPro=(k1*(f1-minDis))/(aveDis-minDis);
    else
        croPro=k2;
    end
    
    a=rand();
    if a<=croPro
        rand1=randsrc(1,1,2:col-1);
        rand2=randsrc(1,1,2:col-1);
        [ cross1,cross2 ] = twoCross( rand1,rand2,sleFromPop(i,:),sleFromPop(i+1,:),col );
%         if i>1
%             for j=1:i-1
%                 while(comshuzu(croToSle(j,:),cross1)||comshuzu(croToSle(j,:),cross2))
%                     rand1=randsrc(1,1,2:col-1);
%                     rand2=randsrc(1,1,2:col-1);
%                     [ cross1,cross2 ] = twoCross( rand1,rand2,sleFromPop(i,:),sleFromPop(i+1,:),col );
%                 end
%             end
%         end
        croToSle(i,:)=cross1;
        croToSle(i+1,:)=cross2;
    end
end
end
%         if(rand1==rand2)
%             croToSle(i,:)=sleFromPop(i,:);
%             croToSle(i+1,:)=sleFromPop(i+1,:);
%         end
%         if(rand1~=rand2)
%             cross1=sleFromPop(i,:);
%             cross2=sleFromPop(i+1,:);
%             s=min(rand1,rand2);
%             e=max(rand1,rand2);
%             for j=s:e
%                 cross1(j)=sleFromPop(i+1,j);
%                 cross2(j)=sleFromPop(i,j);
%             end
%             %计算子代1，为cross1
%             for j=2:col-1
%                 if(j<s||j>e)
%                     cross1(j)=sleFromPop(i,j);
%                     x=find(cross1==cross1(j));
%                     x1=x(x~=j);
%                     while(~isempty(x1))
%                         cross1(j)=sleFromPop(i,x1);
%                         x=find(cross1==cross1(j));
%                         x1=x(x~=j);
%                     end
%                 end
%             end
%              %计算子代2，为cross2
%              for j=2:col-1
%                 if(j<s||j>e)
%                     cross2(j)=sleFromPop(i+1,j);
%                     y=find(cross2==cross2(j));
%                     y1=y(y~=j);
%                     while(~isempty(y1))
%                         cross2(j)=sleFromPop(i+1,y1);
%                         y=find(cross2==cross2(j));
%                         y1=y(y~=j);
%                     end
%                 end
%              end

