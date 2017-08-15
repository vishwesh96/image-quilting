function [ OverlapB ] = Overlap( BovOne,BovTwo , O)

BWidth = size(BovOne, 1);
e = sum((BovTwo-BovOne).^2,3); %Error Surface
E = e;
%Fill the Error path table
for i = 2:BWidth
    for j = 1:O
       E(i,j) = e(i,j)+ min([ E(i-1,max(j-1,1))  E(i-1,j) E(i-1,min(j+1,O))]);
    end
end
% Find the minimum error
[Error,J] = min (E(BWidth,:));

%Back track the minimum path
PathInd = zeros(BWidth,1);

PathInd(BWidth,1) = J;        %Initialize
for i = BWidth-1:-1:1
    PrevE = E(i+1,PathInd(i+1,1))-e(i+1,PathInd(i+1,1));
    if PrevE == E( i, max(PathInd(i+1)-1,1) )
        PathInd(i,1) = max(PathInd(i+1,1)-1,1);
    elseif PrevE == E(i,min(PathInd(i+1,1)+1,O))
        PathInd(i,1) = min(PathInd(i+1,1)+1,O);
    else
        PathInd(i,1) = PathInd(i+1,1);
    end
end

%Output Overlap Block Only
OverlapB = zeros(BWidth,O,3);
for i = 1:BWidth
    OverlapB(i,1:PathInd(i,1),:) = BovOne(i,1:PathInd(i,1),:);
    OverlapB(i,PathInd(i,1)+1:O,:) = BovTwo(i,PathInd(i,1)+1:O,:);
end
end

