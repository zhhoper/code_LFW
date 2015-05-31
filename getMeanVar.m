function [meanValue, varValue] = getMeanVar(F, G, inter_s, intra_s, training, m)
% this is used to compute the mean and variance for conditional
% distribution
% m is the number of training data
% training contains all the training data (the center should be 0)

tmp = sum(training,1);
meanValue = (inter_s*(F + m*G)*tmp')';
%meanValue = inter_s*F*tmp + m*inter_s*G*tmp;
varValue = inter_s + intra_s - m*inter_s*(F + m*G)*inter_s;
end