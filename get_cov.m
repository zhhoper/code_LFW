function [inter_s, intra_s] = get_cov(label, training)
% [inter_s, intra_s] = get_cov(label, training)
%
% this function is used to get the inter class variance and intra class
% variance for the training data.
% OUTPUT:
% inter_s : inter class variance
% intra_s : intra class variance
% INPUT:
% label : contains all the labels for training data
% training : contains all the training data, each row is an instance, data
% must be centeralized

% training should be centralized otherwise, give an error
thr = 1e-10;
meanValue = mean(training);
tmp = meanValue > thr;
if sum(tmp)
    error('Input training data should be centralized');
end

id = unique(label);

numDim = size(meanValue,2);
numClass = length(id);

meanGroup = zeros(numClass, numDim);
inter_s = zeros(numDim);
intra_s = zeros(numDim);
totalNum = 0;

for i = 1 : numel(id)
    tid = id(i);
    indicator = label == tid;
    
    num = sum(indicator);
    totalNum = totalNum + num;
    
    data = training(indicator,:);
    meanGroup(i,:) = mean(data);
    
    % inter class variance computataion
    inter_s = inter_s + num*meanGroup(i,:)'*meanGroup(i,:);
    
    % intra class variance computation
    intra_s = intra_s + (data - repmat(meanGroup(i,:), num, 1))'*...
        (data - repmat(meanGroup(i,:), num, 1));
end
    inter_s = inter_s/totalNum;
    intra_s = intra_s/totalNum;
end
