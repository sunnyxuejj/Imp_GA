function [minEngEnd,minEngOriEnd] = diff_n( n )
%UNTITLED Summary of this function goes here
% route planning with different target points

tar1=randi([-100,100],n,2);
tar1=[[0,0];tar1];
tarNum1=size(tar1,1);

% plot the positions of all target points
% figure(1);
% scatter(tar1(1,1),tar1(1,2),'r');hold on;
% scatter(tar1(2:tarNum1,1),tar1(2:tarNum1,2),'bx');hold on;
% axis([-120 120 -120 120]);

popSiz = 20; % Initializes the genetic algorithm population size
sleCom=0.95;% select operator
croPro = 0.8; % crossover probability
mutPro = 0.4; % mutation probability
cycNum=81;   % the number of iterations

% The distance between each point is calculated to form a distance matrix
ptopdis1=zeros(tarNum1,tarNum1);
ptopdis1=calptopDis( tar1 );

% our improved GA
% generate population, where each individual represents a route
poplation = zeros(popSiz, tarNum1+1);
for i=1:popSiz
    poplation(i,1) = 1;
    poplation(i,tarNum1+1) = 1;
    poplation(i,2:tarNum1)=randperm(tarNum1-1)+1;
    if i>1
        for j=1:i-1
            while(comshuzu( poplation(j,:),poplation(i,:) ))
                poplation(i,1) = 1;
                poplation(i,tarNum1+1) = 1;
                poplation(i,2:tarNum1)=randperm(tarNum1-1)+1;
            end
        end
    end
end


 gen=1;    
 % save shortest route in each iteration for drawing
 maxFitDeg=zeros(cycNum,1);
 maxFitPath = zeros(cycNum,tarNum1+1);
 minEng=zeros(cycNum,1);
 
 % GA
 [fitDeg,totalEng] = impFitness( tar1,poplation,ptopdis1 );   % fitness and energy comsumption calculation
 [minEng(gen),maxFitDeg(gen),maxFitPath(gen,:) ] = findMaxFit( fitDeg,poplation,totalEng );  % Record the minimum energy consumption, maximum fitness and corresponding path
 sleFromPop  = select( poplation,floor(popSiz*sleCom),fitDeg); % selection operation of GA
 [fitDegAfterSle,totalEngAfterSle] = impFitness( tar1,sleFromPop,ptopdis1 );   % fitness and energy comsumption calculation after selection
 croToSle = impCross( sleFromPop,totalEngAfterSle);  % crossover operation of GA
 [fitDeg,totalEngAfterCro] = impFitness( tar1,croToSle,ptopdis1 );   % fitness and energy comsumption calculation after selection after crossover
 mutToCro  = impMut( croToSle,totalEngAfterCro );  % mutation operation of GA
 gen=gen+1;
 while(gen<=cycNum)
     [fitDeg,totalEng] = impFitness( tar1,sleFromPop,ptopdis1 );  % fitness and energy comsumption calculation
     [minEng(gen),maxFitDeg(gen),maxFitPath(gen,:) ] = findMaxFit( fitDeg,sleFromPop,totalEng );  % Record the minimum energy consumption, maximum fitness and corresponding path
     sleFromPop  = newSelect( mutToCro,sleFromPop,floor(popSiz*sleCom),gen,tar1,ptopdis1); % new selection
%      [fitDegAfterMut,totalEngAfterMut] = impFitness( tar1,mutToCro,ptopdis1 );   
%      sleFromPop = impSlect( sleFromPop,mutToCro,totalEng,totalEngAfterMut,gen );
     croToSle = impCross( sleFromPop,totalEng);  % crossover operation of GA
     [fitDeg,totalEngAfterCro] = impFitness( tar1,croToSle,ptopdis1 );   % fitness and energy comsumption calculation
     mutToCro  = impMut( croToSle,totalEngAfterCro );  % mutation operation of GA
     % There will be an **evolutionary reversal** after every five iterations 
     % and this evolution will only occur when each individual becomes more fit after the reversal
     if(mod(gen,5)==0)
         evoToPop = impEvolution( tar1,mutToCro,ptopdis1); % evolutionary reversal of current population 
         mutToCro=evoToPop;
      end
     gen=gen+1;
 end
 gen=gen-1;
 minEngEnd=minEng(gen);
 
% Original GA
 genOri=1;   
 maxFitDegOri=zeros(cycNum,1);
 maxFitPathOri = zeros(cycNum,tarNum1+1);
 minEngOri=zeros(cycNum,1);
 
 while(genOri<=cycNum)
     [fitDegOri,totalEngOri]=impFitness( tar1,poplation,ptopdis1 );   % fitness and energy comsumption calculation
     [minEngOri(genOri),maxFitDegOri(genOri),maxFitPathOri(genOri,:) ] = findMaxFit( fitDegOri,poplation,totalEngOri );  % Record the minimum energy consumption, maximum fitness and corresponding path
     sleFromPop  = select( poplation,floor(popSiz*sleCom),fitDegOri); % selection of original GA
     croToSle = oriCross( sleFromPop,croPro);  % crossover of original GA
     mutToCro  = oriMut( croToSle,mutPro);  % mutation of original GA
     poplation=[mutToCro;poplation];
     
     genOri=genOri+1;
 end
 genOri=genOri-1;
 minEngOriEnd=minEngOri(genOri);

% % plot initial path
% adjMat = adjoin( maxFitPath(1,:) );  % The adjacency matrix is calculated according to the path planning
% figure(2);
% scatter(tar1(1,1),tar1(1,2),'r');hold on;
% scatter(tar1(2:tarNum1,1),tar1(2:tarNum1,2),'bx');hold on;
% axis([-120 120 -120 120]);
% title("Initial path");
% ylabel('y');
% xlabel('x');
% for c=2:tarNum1
%     text(tar1(maxFitPath(1,c),1)+1,tar1(maxFitPath(1,c),2)+1,num2str(c-1));
% end
% gplot(adjMat,tar1,'g-');
% hold on;
% 
% % plot optimal path
% adjMat = adjoin( maxFitPath(gen,:) );  % The adjacency matrix is calculated according to the path planning
% figure(3);
% scatter(tar1(1,1),tar1(1,2),'r');hold on;
% scatter(tar1(2:tarNum1,1),tar1(2:tarNum1,2),'bx');hold on;
% axis([-120 120 -120 120]);
% title("Final path");
% ylabel('y');
% xlabel('x');
% for c=2:tarNum1
%     text(tar1(maxFitPath(gen,c),1)+1,tar1(maxFitPath(gen,c),2)+1,num2str(c-1));
% end
% gplot(adjMat,tar1,'g-');
% hold on;
% 
%
% % plot the relationship between the number of cycles and the minimum distance
% figure(4);
% title('Convergence£¨minimal distance of path in each iteration£©');
% ylabel('Diatnace/m');
% xlabel('Iteration');
% plot(1:cycNum,minEng,'r-');
% hold on;
% plot(1:cycNum,minEngOri);
% grid on;
% legend("Our Improved GA","Original GA");
% title('Convergance curves');

end

