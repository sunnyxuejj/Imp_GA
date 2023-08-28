n=10;
tar1=randi([-100,100],n,2);
tar1=[[0,0];tar1];
tarNum1=size(tar1,1);

figure(1);
scatter(tar1(1,1),tar1(1,2),'r');hold on;
scatter(tar1(2:tarNum1,1),tar1(2:tarNum1,2),'bx');hold on;
axis([-120 120 -120 120]);

popSiz = 20; 
sleCom=0.8;
croPro = 0.8; 
mutPro = 0.4; 
cycNum=100;   

ptopdis1=zeros(tarNum1,tarNum1);
ptopdis1=calptopDis( tar1 );

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
 maxFitDeg=zeros(cycNum,1);
 maxFitPath = zeros(cycNum,tarNum1+1);
 minDis=zeros(cycNum,1);
 
 % GA
 while(gen<cycNum)
     [fitDeg,sunDis]=fitness( poplation,ptopdis1 );   % fitness and total distance of a path
     [minDis(gen),maxFitDeg(gen),maxFitPath(gen,:) ] = findMaxFit( fitDeg,poplation,sunDis );
     sleFromPop  = select( poplation,floor(popSiz*sleCom),fitDeg); % selection
     croToSle = oriCross( sleFromPop,croPro);  % crossover
     mutToCro  = oriMut( croToSle,mutPro);  % mutation
     poplation=mutToCro;
 end  
 
% After many iterations, the optimal path is recorded in maxFitPath
[fitDeg,sunDis]=fitness( poplation,ptopdis1 ); 
[minDis(gen),maxFitDeg(gen),maxFitPath(gen,:) ] = findMaxFit( fitDeg,poplation,sunDis );
 

% initial route
adjMat = adjoin( maxFitPath(1,:) );
figure(2);
scatter(tar1(1,1),tar1(1,2),'r');hold on;
scatter(tar1(2:tarNum1,1),tar1(2:tarNum1,2),'bx');hold on;
axis([-120 120 -120 120]);
title("Path");
ylabel('y');
xlabel('x');
for c=2:tarNum1
    text(tar1(maxFitPath(1,c),1)+1,tar1(maxFitPath(1,c),2)+1,num2str(c-1));
end
gplot(adjMat,tar1,'g-');
hold on;
 % optimal route
adjMat = adjoin( maxFitPath(gen,:) );
figure(3);
scatter(tar1(1,1),tar1(1,2),'r');hold on;
scatter(tar1(2:tarNum1,1),tar1(2:tarNum1,2),'bx');hold on;
axis([-120 120 -120 120]);
title("Path");
ylabel('y');
xlabel('x');
for c=2:tarNum1
    text(tar1(maxFitPath(gen,c),1)+1,tar1(maxFitPath(gen,c),2)+1,num2str(c-1));
end
gplot(adjMat,tar1,'g-');
hold on;


% minimal distance versus iterations
figure(4);
title('convergence');
ylabel('Distance/m');
xlabel('iteration');
plot(1:cycNum,minDis);
grid on;

    