function [label, data] = generate_data(inter_s, intra_s, numClass, numSamples)
% [label, data] = generate_data(inter_s, intra_s)
% this function is used to generate synthetic data for joint bayesian, all
% the data with mean being zeros
% INPUT:
% inter_s : inter class variance
% intra_s : intra class variance
% numClass : number of class we want to generate
% numSamples : number of samples for each class
% OUTPUT:
% label is the label of each data
% data contains the data generated, each row is a data

dim = size(inter_s,1);
if sum(sum(size(inter_s) ~= size(intra_s)))
    error('inter_s and intra_s are not the same size');
end

% generate inter variance 
meanValue = zeros(1, dim);
R = mvnrnd(meanValue, inter_s, numClass);

% generate intra variance
totalNum = numClass * numSamples;
tmpR = mvnrnd(meanValue, intra_s, totalNum);

data = repmat(R, numSamples, 1) + tmpR;
label = repmat([1:numClass]', numSamples, 1);
end