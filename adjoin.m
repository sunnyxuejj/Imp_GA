function adjMat = adjoin( PatPlan )
% calculate adjacency matrix

tarNum=size(PatPlan,2);
adjMat=zeros(tarNum,tarNum);
for i=1:tarNum-1
    point1=PatPlan(i);
    point2=PatPlan(i+1);
    adjMat(point1,point2)=1;
    adjMat(point2,point1)=1;
end

