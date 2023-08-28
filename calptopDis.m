function ptopdis = calptopDis( tarPos )
% The distance between each point is calculated to form a distance matrix
n=size(tarPos,1);
for i=1:n
    for j=i+1:n
        d=(tarPos(i,1)-tarPos(j,1)).^2+(tarPos(i,2)-tarPos(j,2)).^2;
        ptopdis(i,j)=d^(0.5);
        ptopdis(j,i)=ptopdis(i,j);
    end
end
end

