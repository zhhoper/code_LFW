function [inter_s, intra] = EM_update(data, label, k)
% [inter_s, intra_mean, intra_s] = EM_update(data, k) 
%
% This function is to use EM to update inter_s and intra_s, we suppose
% class ID variable is a single Gaussian, intra class variable is a mixture
% of Gaussian. 
% INPUT:
% data : the matrix containing all the training data, each row of the
% matrix corresponds to a data. The mean of data should be zero
% label : a vector indicating the identity of each data
% k : the number of guassians for intra class variable
% OUTPUT:
% inter_s : the inter class variance
% intra : a structure indicating the mean and variance of each Gaussian
% component

dim = size(data,2);       % dimension of the feature

% allocate the space 
inter_s = zeros(dim);
intra = struct;
for i = 1 : k
    intra(i).mean = zeros(1, dim);
    intra(i).var = zeros(dim);
end

% the identity of all the samples
index_identity = unique(label);
numFaces = length(index_identity);

% u_identity is used to store all the values for the identity 
u_identity = zeros(numFaces, dim);

% u_intra is used to store the values for the intra variance
u_intra = -1*ones(size(data));

% initialize u as the mean of the class, and epson as the residual of data
% point minus the mean
for i = 1 : numFaces
    tmp_index = label == index_identity(i);
    tmp_data = data(tmp_index);
    u_identity(i,:) = mean(tmp_data);
    numData = sum(tmp_index);
    u_intra(tmp_index) = tmp_data - repmat(u_identity(i,:), numData,1);
end

diffMean = inf;
diffVar = inf;
max_ite = 10;
thr1 = 1;
thr2 = 1;

while diffMean > thr1 || diffVar > thr2 || count < max_ite
    intra_old = intra;
    
    % using EM to update the mixture of Gaussian
    intra = EM_mixGaussian(u_intra);
    
    % updating indentity and intra variables
    
    % compute the difference
    diffMean = 0;
    diffVar = 0;
    for i = 1 : k
        diffMean = diffMean + norm(intra(i).mean - intra_old(i).mean, 'fro');
        diffVar = diffVar + norm(intra(i).var - intra_old(i).var, 'fro');
    end
    count = count + 1;
end

end