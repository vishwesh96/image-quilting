function [ Block ] = texCut2(CorrOrig, OrigTex, CBlock, patch, Type, alpha,O, IterNum,Output)
Left = 0;
Up = 1;
Both = 2;

[M,N,X]= size(OrigTex);
[m,n,x] = size(CBlock);
LeftCut = CBlock(:,1:O,:);
UpCut = CBlock(1:O,:,:);

Error = Inf;
MinBlock = double(zeros(m,n,3));


if IterNum == 1
    for k = 1:4000
        i = randi([1, size(OrigTex,1) - m], 1, 1);
        j = randi([1, size(OrigTex,2) - n], 1, 1);
    %for i = 1:M-m+1
     %   for j = 1:N-n+1
            Block = OrigTex(i:i+m-1,j:j+n-1,:);
            LeftBlock = Block(1:m,1:O,:);
            UpBlock = Block(1:O,1:n,:);
            error2 = sum(sum((patch-CorrOrig(i:i+m-1,j:j+n-1)).^2));        
            if Type == Left
                error1 = sum(sum(sum((LeftCut-LeftBlock).^2)));
                error = alpha*error1  + (1-alpha)*error2;
                if error < Error
                    Error = error;
                    MinBlock = Block;
                end
            elseif Type == Up
                error1 = sum(sum(sum((UpCut-UpBlock).^2)));
                error = alpha*error1  + (1-alpha)*error2;
                if error < Error
                    Error = error;
                    MinBlock = Block;
                end
            else 
                error1 = sum(sum(sum((UpCut-UpBlock).^2))) + sum(sum(sum((LeftCut-LeftBlock).^2)));
                error = alpha*error1  + (1-alpha)*error2;            
                if error < Error
                    Error = error;
                    MinBlock = Block;
                end
            end
       % end
    end
else
    for k = 1:1000
        i = randi([1, size(OrigTex,1) - m], 1, 1);
        j = randi([1, size(OrigTex,2) - n], 1, 1);
    %for i = 1:M-m+1
     %   for j = 1:N-n+1
            Block = OrigTex(i:i+m-1,j:j+n-1,:);
            LeftBlock = Block(1:m,1:O,:);
            UpBlock = Block(1:O,1:n,:);
            error2 = sum(sum((patch-CorrOrig(i:i+m-1,j:j+n-1)).^2));  
            error1 = sum(sum(sum(Block(:,:,:) - Output(:,:,:)).^2));
            %error1 = 0;
            if Type == Left
                error1 = error1 + sum(sum(sum((LeftCut-LeftBlock).^2)));
                error = alpha*error1  + (1-alpha)*error2;
                if error < Error
                    Error = error;
                    MinBlock = Block;
                end
            elseif Type == Up
                error1 = error1 + sum(sum(sum((UpCut-UpBlock).^2)));
                error = alpha*error1  + (1-alpha)*error2;
                if error < Error
                    Error = error;
                    MinBlock = Block;
                end
            else 
                error1 = error1 + sum(sum(sum((UpCut-UpBlock).^2))) + sum(sum(sum((LeftCut-LeftBlock).^2)));
                error = alpha*error1  + (1-alpha)*error2;            
                if error < Error
                    Error = error;
                    MinBlock = Block;
                end
            end
        %end
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