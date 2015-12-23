function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = .01;
sigma = .01;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
prederr = zeros(8);
C = .01;
sigma = .01;
for i = 1:8
    valsig(i) = sigma;
    for j = 1:8
        valC(j) = C;
        model = svmTrain(X, y, C,  @(x1, x2) gaussianKernel(x1, x2, sigma));
        predictions = svmPredict(model,Xval);
        prederr(i,j) = mean(double(predictions ~= yval));
        if i == 1 && j == 1
            m = prederr(i,j)
            Cfin = C
            sigfin = sigma
        elseif prederr(i,j) < m
            m = prederr(i,j)
            Cfin = C
            sigfin = sigma
        end
        if mod(j,2) == 0
            C = C*10/3;
        else
            C = C*3;
        end
    end
    if mod(i,2) == 0
        sigma = sigma*10/3;
    else
        sigma = sigma*3;
    end
    C = .01;
end

C = Cfin;
sigma = sigfin;


% =========================================================================

end
