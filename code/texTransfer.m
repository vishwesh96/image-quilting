function [ Output ] = texTransfer(OrigTex, TargetImage, BWidth, O, NumIter)

OutM = size(TargetImage,1);
OutN = size(TargetImage,2);
Output = double(zeros(OutM, OutN,3));
Left = 0;
Up = 1;
Both = 2;

alpha = 0.4;

CorrOrig = OrigTex(:,:,1)*0.2126 + OrigTex(:,:,2)*0.7152 + OrigTex(:,:,3)*0.0722; 
CorrTarget = TargetImage(:,:,1)*0.2126 + TargetImage(:,:,2)*0.7152 + TargetImage(:,:,3)*0.0722; 

CorrOrig = imgaussfilt(CorrOrig,2);
CorrTarget= imgaussfilt(CorrTarget,2);


%initalize output
[patch,error] = corrError(CorrTarget(1:BWidth,1:BWidth), CorrOrig, OrigTex);
Output(1:BWidth,1:BWidth) = patch;
    
for k = 1:NumIter
    
    if NumIter ~= 1 
        alpha = 0.8*(k-1)/(NumIter-1) + 0.1;
    end
    BWidth
   
    for i = O+1:BWidth-O:OutM
        for j = O+1:BWidth-O:OutN
%             LeftBlock = Output(i-O:min(i-O-1+BWidth,OutM),j-O:j-1,:);
%             UpBlock = Output(i-O:i-1,j-O:min(j-O-1+BWidth,OutN),:);
            CBlock = Output(i-O:min(i-O-1+BWidth,OutM),j-O:min(j-O-1+BWidth,OutN),:);
            Block = zeros(min(i-O-1+BWidth,OutM)-i+O+1,min(j-O-1+BWidth-j+O+1,OutN),3);
            patch = CorrTarget(i-O:min(i-O-1+BWidth,OutM),j-O:min(j-O-1+BWidth,OutN));
            if i > BWidth
                if j > BWidth
                      Block = texCut(CorrOrig, OrigTex,CBlock,patch,Both,alpha,O,k);
                else
                     Block = texCut(CorrOrig, OrigTex,CBlock,patch,Up,alpha,O,k);                
                end
                Output(i-O:min(i-O-1+BWidth,OutM),j-O:min(j-O-1+BWidth,OutN),:) = Block;           
            end
            if (i==O+1) && (j>BWidth)
                Block = texCut(CorrOrig,OrigTex,CBlock,patch,Left,alpha,O,k);   
                Output(i-O:min(i-O-1+BWidth,OutM),j-O:min(j-O-1+BWidth,OutN),:) = Block;         
            end
        end
        i
    end
    BWidth = ceil(2*BWidth/3);
    %change O also%
    O = ceil(2*O/3);  
end
end

