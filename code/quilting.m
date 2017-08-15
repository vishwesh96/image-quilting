function [ Output ] = quilting( OrigTex, BWidth, O, OutM, OutN )

S = double(zeros(BWidth, BWidth,3));
Output = double(zeros(OutM, OutN,3));
Left = 0;
Up = 1;
Both = 2;

%initalize output
%pick the first patch randomly
r = randi([1, size(OrigTex,1) - BWidth], 1, 1);
c = randi([1, size(OrigTex,2) - BWidth], 1, 1);

Output(1:BWidth,1:BWidth,:) = OrigTex(r:r+BWidth-1,c:c+BWidth-1,:);
    
for i = O+1:BWidth-O:OutM
    for j = O+1:BWidth-O:OutN
        LeftBlock = Output(i-O:min(i-O-1+BWidth,OutM),j-O:j-1,:);
        UpBlock = Output(i-O:i-1,j-O:min(j-O-1+BWidth,OutN),:);
        Block = zeros(min(i-O-1+BWidth,OutM)-i+O+1,min(j-O-1+BWidth-j+O+1,OutN),3);
        if i > BWidth
            if j > BWidth
                  Block = minCut(OrigTex,LeftBlock,UpBlock,Both);
            else
                 Block = minCut(OrigTex,LeftBlock,UpBlock,Up);                
            end
            Output(i-O:min(i-O-1+BWidth,OutM),j-O:min(j-O-1+BWidth,OutN),:) = Block;           
        end
        if (i==O+1) && (j>BWidth)
            Block = minCut(OrigTex,LeftBlock,UpBlock,Left);   
            Output(i-O:min(i-O-1+BWidth,OutM),j-O:min(j-O-1+BWidth,OutN),:) = Block;         
        end
    end
    i
end
end

