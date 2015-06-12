function [inter_s, intra_s] = get_cov_outlier(label, training)
% [inter_s, intra_s, inter_so, intra_so] = get_cov_outlier(id_WDRef, training)
%
% This function is used to compute inter variance and intra variance using
% manually defined outlier Guassian function


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

% Suppose ourlier is 5 times bigger than the original clustering
tim = 2;
out_inter_s = tim*inter_s;
out_intra_s = tim*intra_s;

sig1 = inter_s + intra_s;
sig2 = out_inter_s + out_intra_s;

D1 = eig(sig1);

invSig1 = pinv(sig1);
invSig2 = pinv(sig2);
invSig = invSig2 - invSig1;

numSamples = numel(label);
tmpDist = zeros(numSamples, 1);
for i = 1 : numel(label)
    tmpDist(i) = training(i,:)*invSig*training(i,:)';
end
ind = tmpDist > (1-tim)*sum(log(D1));

tmpTraining = training(ind);
tmpId = label(ind);

[inter_s, intra_s] = get_cov(tmpId, tmpTraining);
end
