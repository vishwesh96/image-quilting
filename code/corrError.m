function [ Output, Error ] = corrError(Input, CorrOrig, OrigTex)
M = size(CorrOrig,1)
N = size(CorrOrig,2)
m = size(Input,1);
n = size(Input,2);

Error = Inf;
Output = double(zeros(m,n,3));    
    for i = 1:M-m+1
        for j = 1:N-n+1
            patch = CorrOrig(i:i+m-1,j:j+n-1);
            error = sum(sum((patch-Input).^2));
            if error < Error
                Error = error;
                Output = OrigTex(i:i+m-1,j:j+n-1);
            end
        end        
    end    
end