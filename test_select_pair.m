% This test file is used to do tesing on LFW with selected pair of data
close all;
clc;

load('../LFW/lbp_WDRef.mat');
load('../LFW/id_WDRef.mat');

dim = 2000;  % PCA reduce dimension to 2000 suggested by Joint Bayesian paper
ind = 1;

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
    intra_s = variance.intra_s;
    fprintf('Done!\n');
else
    fprintf('Computing the inter and intra class variance...\n');
    [inter_s, intra_s] = get_cov(id_WDRef, training);
    fprintf('Done!\n');
end

% get A and G
fprintf('Get A and G...\n');
[A, G] = get_AG(inter_s, intra_s);
fprintf('Done!\n');

% doing test for LFW
fprintf('Loading LFW data...\n');
load('../LFW/pairlist_lfw.mat');
load('../LFW/lbp_lfw.mat');
load('../LFW/id_lfw.mat');
fprintf('Done!\n');

% pre-process testing data
data = (double(lbp_lfw) - repmat(meanValue, size(lbp_lfw, 1), 1))*projection;

%% selecting pair
numSamples = 10;
[select_intra, select_extra] = select_pairs(pairlist_lfw, id_lfw, numSamples);

%% use joint bayesian method
fprintf('Compute the distance for intra class...\n');
intra_distance = sim_jointBayesian_syn(select_intra, data, id_lfw, A, G, numSamples);
fprintf('Done!\n');

fprintf('Compute the distance for extra class...\n');
extra_distance = sim_jointBayesian_syn(select_extra, data, id_lfw, A, G, numSamples);
fprintf('Done!\n');

fprintf('Draw ROC curve...\n');
figure;
intra_precision = struct;
extra_precision = struct;

[intra_precision.mean, extra_precision.mean] = showCurve(intra_distance.mean, extra_distance.mean, 'b-', 2);
hold on;
[intra_precision.min, extra_precision.min] = showCurve(intra_distance.min, extra_distance.min, 'g-.', 2);
hold on;
[intra_precision.max, extra_precision.max] = showCurve(intra_distance.max, extra_distance.max, 'k--', 2);
hold on;
[intra_precision.normal, extra_precision.normal] = showCurve(intra_distance.normal, extra_distance.normal, 'm-', 2);
save(sprintf('intra_precision_%d', numSamples), 'intra_precision');
save(sprintf('extra_precision_%d', numSamples), 'extra_precision');
fprintf('Done!\n');

%% use point to set method
fprintf('Compute the distance for intra class...\n');
p_s_intra = sim_point_set_syn(select_intra, data, id_lfw, inter_s, intra_s, numSamples);
fprintf('Done!\n');

fprintf('Compute the distance for extra class...\n');
p_s_extra = sim_point_set_syn(select_extra, data, id_lfw, inter_s, intra_s, numSamples);
fprintf('Done!\n');

fprintf('Draw ROC curve...\n');
hold on;
[p_s_intra_precision, p_s_extra_precision] = showCurve(p_s_intra, p_s_extra, 'r-', 2);
legend('mean', 'min', 'max', 'normal', 'joint');
save(sprintf('p_s_intra_precision_%d', numSamples), 'p_s_intra_precision');
save(sprintf('p_s_extra_precision_%d', numSamples), 'p_s_extra_precision');
fprintf('Done!\n');

