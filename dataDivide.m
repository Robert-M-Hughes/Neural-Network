function [xtrain, xtest, ytrain, ytest] = dataDivide(Z,Y,j)

    a = (j-1)*500+1;
    b = j*500;
    
    temparray = [Z,Y];
    
    temparrayTest = temparray(a:b,:);
    
    temparraytrain = setdiff(temparray,temparrayTest,'rows');
    
    xtest = temparrayTest(:,1:9);
    ytest = temparrayTest(:,10);
    
    xtrain = temparraytrain(:,1:9);
    ytrain = temparraytrain(:,10);
    
    [n,~] = size(xtest);  
    xtest = [ones(n,1),xtest];  
   

end 
