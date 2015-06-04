% This test file is used to do tesing on LFW
close all;
clc;

load('../LFW/lbp_WDRef.mat');
load('../LFW/id_WDRef.mat');

dim = 200;  % PCA reduce dimension to 2000 suggested by Joint Bayesian paper
ind = 0;
numGaussian = 10;  % number of guassian 

% get pca results
if exist('Result_mat/pcaResult.mat', 'file') && ind
    fprintf('Loading PCA results...\n');
    load('Result_mat/pcaResult.mat');
    training = pcaResult.training;
    projection = pcaResult.projection;
    meanValue = pcaResult.meanValue;
    clear pcaResult;
    fprintf('Done!\n');
else
    fprintf('Computing PCA dimension reduction...\n');
    [training, projection, meanValue] = get_projection_PCA(double(lbp_WDRef), dim);
    fprintf('Done!\n');
    
end

% get inter and intra variance
if exist('variance.mat', 'file') && ind
    fprintf('Loading inter and intra variance...\n');
    load('variance.mat');
    inter_s = variance.inter_s;
    intra = variance.intra_s;
    fprintf('Done!\n');
else
    fprintf('Computing the inter and intra class variance...\n');
    [inter_s, intra] = EM_update(training, id_WDRef, numGaussian);
    fprintf('Done!\n');
end

% doing test for LFW
fprintf('Loading LFW data...\n');
load('../LFW/pairlist_lfw.mat');
load('../LFW/lbp_lfw.mat');
load('../LFW/id_lfw.mat');
fprintf('Done!\n');

% pre-process testing data
data = (double(lbp_lfw) - repmat(meanValue, size(lbp_lfw, 1), 1))*projection;

% process intra
tmp = intra.Sigma + repmat(inter_s, 1,1, numGaussian);
intra_s = gmdistribution(intra.mu, tmp, intra.PComponents);

%% use joint bayesian method
fprintf('Compute the distance for intra class...\n');
intra_distance = sim_jointBayesian_mixture(pairlist_lfw.IntraPersonPair, data, inter_s, intra_s);
fprintf('Done!\n');

fprintf('Compute the distance for extra class...\n');
extra_distance = sim_jointBayesian_mixture(pairlist_lfw.ExtraPersonPair, data, inter_s, intra_s);
fprintf('Done!\n');

fprintf('Draw ROC curve...\n');
figure;

[intra_precision, extra_precision] = showCurve(intra_distance, extra_distance, 'b-', 2);
save(sprintf('mixture_intra_precision_dim_%d_numGaussian_%d', dim, numGaussian), 'intra_precision');
save(sprintf('mixture_extra_precision_dim_%d_numGaussian_%d', dim, numGaussian), 'extra_precision');
fprintf('Done!\n');