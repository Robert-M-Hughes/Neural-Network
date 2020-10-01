function [error_val] = error_calc(w, xtest, ytest)


        error_val = 0;
    for k = 1:500
        
        tempError = (( ytest(k) - ( sign( dot( w,xtest(k,:)))))^2) /2;
        error_val = tempError + error_val;
    end 
        error_val = error_val/500;
end