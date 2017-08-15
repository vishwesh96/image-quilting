function [ Block ] = minCut(OrigTex, LeftCut, UpCut, Type)
Left = 0;
Up = 1;
Both = 2;

[M,N,X]= size(OrigTex);
m = size(LeftCut,1);
n = size(UpCut,2);
O = size(LeftCut,2);
Error = Inf;
MinBlock = double(zeros(m,n,3));
for i = 1:M-m+1
    for j = 1:N-n+1
 
        Block = OrigTex(i:i+m-1,j:j+n-1,:);
        LeftBlock = Block(1:m,1:O,:);
        UpBlock = Block(1:O,1:n,:);
        if Type == Left
            error = sum(sum(sum((LeftCut-LeftBlock).^2)));
            if error < Error
                Error = error;
                MinBlock = Block;
            end
        elseif Type == Up
            error = sum(sum(sum((UpCut-UpBlock).^2)));
            if error < Error
                Error = error;
                MinBlock = Block;
            end
        else 
            error = sum(sum(sum((UpCut-UpBlock).^2))) + sum(sum(sum((LeftCut-LeftBlock).^2)));
            if error < Error
                Error = error;
                MinBlock = Block;
            end
        end
    end
end

LeftBlock = MinBlock(1:m,1:O,:);
UpBlock = MinBlock(1:O,1:n,:);

LeftBlock = Overlap(LeftCut,LeftBlock,O);
UpBlock = permute(Overlap(permute(UpCut,[2 1 3]),permute(UpBlock,[2 1 3]),O), [2 1 3]);

if Type == Left
    MinBlock(1:m,1:O,:) = LeftBlock ;
elseif Type == Up
    MinBlock(1:O,1:n,:) = UpBlock ;
else
    MinBlock(1:m,1:O,:) = LeftBlock ;
    MinBlock(1:O,1:n,:) = UpBlock ;
end
    
Block = MinBlock;
