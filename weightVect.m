function [Z, Y] = weightVect(y, X)
% a 3rd order polynomial set.

    Y = y;
    Y(Y ~= 1) = -1;


    Z=zeros(5000, 9);
    
    for i=1:5000
       Z(i,:)=[X(i,1);X(i,2);(X(i,1))^2;X(i,1)*X(i,2);(X(i,2))^2;(X(i,1))^3;((X(i,1))^2)*X(i,2);
           X(i,1)*(X(i,2))^2; (X(i,2))^3;];
    end
    
    
    
end 