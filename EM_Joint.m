function [inter_s, intra_s, meanMu, meanEpson] = EM_Joint(data, label, inter_s, intra_s)
% EM_Joint(data, label, inter_s, intra_s)
%
% This function is used to implement EM update for inter class variane and
% intra class variance as discussed in paper Joint Bayesian
% INPUT:
% data : data vector, each row represents a sample
% label : the label of each sample
% inter_s : initialized inter variance
% intra_s : initialized intra variance

identity = unique(label);
numClass = length(identity);
[numId, dim]  = size(data);

diff = inf;
count = 0;
max_ite = 20;
thr = 0.1;

while diff > thr && count < max_ite
    % pre_compute F and G for num from 1 to 10
    pre_num = 60;
    preF = struct;
    preG = struct;
    for i = 1 : pre_num
        [tmpF, tmpG] = inv_covariance(inter_s, intra_s, i);
        preF(i).data = tmpF;
        preG(i).data = tmpG;
    end
    count = count + 1;
    
    old_inter_s = inter_s;
    old_intra_s = intra_s;
    % E step to update u and epson
    mu = zeros(numClass,dim);
    epson = zeros(size(data));
    for i = 1 : numClass
        tmp = identity(i);
        tmp_id = label == tmp;
        tmp_data = data(tmp_id,:);
        tmp_sum = sum(tmp_data);
        num = size(tmp_data, 1);
        if num <= pre_num
            F = preF(num).data;
            G = preG(num).data;
        else
            [F, G] = inv_covariance(inter_s, intra_s, num);
        end
        
        mu(i,:) = (tmp_sum*F' + num*tmp_sum*G')*inter_s';
        epson(tmp_id,:) = (tmp_data*F' + repmat(tmp_sum, num, 1)*G')*intra_s';
    end
    meanMu = mean(mu,1);
    meanEpson = mean(epson,1);
    mu = mu - repmat(meanMu, numClass, 1);
    epson = epson - repmat(meanEpson, numId, 1);
    % M step to get covariance matrix
    inter_s = mu'*mu/numClass;
    intra_s = epson'*epson/numId;
    
    diff = max(norm(old_inter_s - inter_s, 'fro'), norm(old_intra_s - intra_s, 'fro'));
end
ccc = 0;