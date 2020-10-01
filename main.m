clear all;
close all;
clc;

%{
1 Input Layer - For the digits data this will be d = 2.
1 hidden layers with 5 nodes (d = 5)
1 output layer
Single output for classifying the digit 1 from the full dataset.
%}

load("usps_modified.mat");
[X,Y] = getfeatures(data);
num_layers = 3;     %number of layers including the input layer
layers(1:num_layers,1) = struct;

Y(Y ~= 1) = -1;

%randomize the data
    D = [X,Y];
    r = randperm(size(D,1));
    d = D(r,:);
    x = d(:,1:2);
    ytemp = d(:,3);


list = {'Batch Gradient Descent','Stochastic Gradient Descent', ...
    'Variable Learning Rate Gradient Descent', ...
    'Steepest Descent (Gradient Descent with Line Search)'};
[indx,tf] = listdlg('PromptString',{'Choose a weight update method',...
    'Only one mode can be chosen at a time.',''},...
    'SelectionMode','single','ListString',list);


[Z, y] = weightVect(ytemp, x);

n = size(x,1);
for i = 1:n % plot data points
    if y(i) == 1
      %line15=0
        scatter(x(i,1),x(i,2),'r','+','LineWidth',2);
        hold on
    end 
    if y(i) ==-1
        scatter(x(i,1),x(i,2),'g','o','LineWidth',2);
        hold on
    end
end
hold on


if(indx == 1)
    
    [net]=backprop(x,y,2,.1,1,'yes');
    
elseif(indx == 2)
    %{
    lamVal = [0.001,0.01,0.1,0.25,0.5,0.75,1];
    compareArray = zeros(7,2);
    for i = 1:7 %run the different lambda values
            error_val = 0;
        for j = 1:10 %10 fold

            [xtrain, xtest, ytrain, ytest] = dataDivide(Z,y,j); 
            lambda = lamVal(i);

            [w] = linreg(xtrain,ytrain,lambda);
            [error_valTemp] = error_calc(w , xtest, ytest);

            error_val = error_valTemp + error_val;
        end

            error_val = error_val/10;

            disp("Lambada Parameter Value: " + lambda);
            disp("Error: " + error_val + "%");
            compareArray(i,1) = error_val;
            compareArray(i,2) = lambda;
    end 


    disp("Minimum error is:" + min(compareArray(:,1)) + "%");
    hold on
    plot( -linreg(x,y,min(compareArray(:,2))))

    %}
elseif(indx == 3)




else
    
end


