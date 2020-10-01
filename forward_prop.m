% Forward Propagation
clear all 
% Network has 3 layers ( 1 input, 1 hidden, 1 output).  The input is a single
% dimension with

theta = @(x) 1./(1+exp(-1*x));  % logistic function
num_layers = 3;  % number of layers including the input layer
layers(1:num_layers, 1) = struct;

% layers defined :
% weight vector matrices W = [w(1); w(2); ... ; w(L)]
% input x(0)
% outputs: X = [x(1), ... , x(L)]
% signals: s(L) = w'(L)*x(L)
% delta functions


% Load data
data_mod = importdata('usps_modified.mat');
[ x_all,y_all ] = getfeatures( data_mod );


% y classified: change all non 1's to 0's to pass into PLA function
y_classified = y_all;
for j = 1:5000
  if y_all(j) ~= 1
    y_classified(j) = 0;
  end
end

% input data and label:
layers(1).x = [1; x_all(1,:)']; % input data
y = y_classified(1);  % output label

% weight vector matrices
% layer 1 (d = 2), layer 2 (d = 5)
layers(2).w = rand(3,5); %[1 1 1 1 1; rand(1) rand(1) rand(1) rand(1) rand(1); rand(1) rand(1) rand(1) rand(1) rand(1)];
layers(3).w = rand(6,1);%[1 rand(1) rand(1) rand(1) rand(1) rand(1)];

% Forward Prapogation
for L = 2:num_layers
    L
    layers(L).s = layers(L).w'*layers(L-1).x;       %calculate signal ***** matrices are off 
    layers(L).x = vertcat(1 ,theta(layers(L).s));    %calculate output
end

% Back Propagation
thetap = @(x) x.*(1-x);     %derivative of logistic function (1/1-e^-s)

x = layers(num_layers).x(2:length(layers(num_layers).x)); %remove bias
layers(num_layers).del = 2.*thetap(x).*(x - y);    %initialize last layer

for  L = num_layers-1:-1:2
    back = 0
    L
    x = layers(L).x(2:length(layers(L).x));             %remove the bias 
    w = layers(L+1).w(2:length(layers(L+1).w));         %remove bias weight
    layers(L).del = thetap(x) .*(w .* layers(L+1).del);   %get next delta
end

% Gradient Calculation
for L = 2:num_layers
    layers(L).grad = layers(L-1).x*layers(L).del';
end

% Weight Update performed stachastically 
eta = 0.1;              %learning rate
for L = 2:num_layers
    layers(L).w = layers(L).w-(eta*layers(L).grad);
end

%Weight Update performed Variable Learning rate
alpha = 1.05;
beta = .65;
eta0 = .1;
iter = 0;
while(iter < 5)
    for L = 2:num_layers
        layers(L).w = layers(L).w-(eta*layers(L).grad);
        [error_valTemp] = error_calc(layers(L).w, x, y);
    end
    g_t = gradient(error_valTemp); 
    v_t = -g_t;
    
    iter = iter + 1;
    
end

%Weight Update performed by Steepest Descent


