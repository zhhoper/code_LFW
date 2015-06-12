% This test file is used to do tesing on LFW
close all;
clc;

load('../LFW/lbp_WDRef.mat');
load('../LFW/id_WDRef.mat');

dim = 100;  % PCA reduce dimension to 2000 suggested by Joint Bayesian paper
ind = 0;
ind2 = 0;

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
    [inter_s, intra_s] = get_cov_outlier(id_WDRef, training);
    fprintf('Done!\n');
end


% if exist('intra_s.mat','file') && exist('inter_s.mat', 'file') && ind2
%     fprintf('Loading inter and intra variance');
%     load('intra_s.mat');
%     load('inter_s.mat');
%     fprintf('Done!');
% else
%     fprintf('EM updating inter_s and intra_s...\n');
%     [inter_s, intra_s, meanMu, meanEpson] = EM_Joint(training, id_WDRef, inter_s, intra_s);
%     fprintf('Done!\n');
% end

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

%% use joint bayesian method
fprintf('Compute the distance for intra class...\n');
intra_distance = sim_jointBayesian_1(pairlist_lfw.IntraPersonPair, data, id_lfw, A, G);
fprintf('Done!\n');

fprintf('Compute the distance for extra class...\n');
extra_distance = sim_jointBayesian_1(pairlist_lfw.ExtraPersonPair, data, id_lfw, A, G);
fprintf('Done!\n');

fprintf('Draw ROC curve...\n');
figure;
intra_precision = struct;
extra_precision = struct;

[intra_precision.mean, extra_precision.mean, bestmean] = showCurve(intra_distance.mean, extra_distance.mean, 'b-', 2);
hold on;
[intra_precision.min, extra_precision.min, bestmin] = showCurve(intra_distance.min, extra_distance.min, 'g-.', 2);
hold on;
[intra_precision.max, extra_precision.max, bestmax] = showCurve(intra_distance.max, extra_distance.max, 'k--', 2);
hold on;
[intra_precision.normal, extra_precision.normal, bestnormal] = showCurve(intra_distance.normal, extra_distance.normal, 'm-', 2);
save(sprintf('intra_precision_outlier_%d', dim), 'intra_precision');
save(sprintf('extra_precision_outlier_%d', dim), 'extra_precision');
fprintf('Done!\n');

%% use point to set method
fprintf('Compute the distance for intra class...\n');
p_s_intra = sim_point_set_1(pairlist_lfw.IntraPersonPair, data, id_lfw, inter_s, intra_s);
fprintf('Done!\n');

fprintf('Compute the distance for extra class...\n');
p_s_extra = sim_point_set_1(pairlist_lfw.ExtraPersonPair, data, id_lfw, inter_s, intra_s);
fprintf('Done!\n');

fprintf('Draw ROC curve...\n');
hold on;
[p_s_intra_precision, p_s_extra_precision, best] = showCurve(p_s_intra, p_s_extra, 'r-', 2);
legend(sprintf('mean: %f', bestmean), sprintf('min: %f', bestmin), ...
    sprintf('max: %f', bestmax), sprintf('normal: %f', bestnormal), sprintf('joint: %f', best));
save(sprintf('p_s_intra_precision_outlier_%d', dim), 'p_s_intra_precision');
save(sprintf('p_s_extra_precision_outlier_%d', dim), 'p_s_extra_precision');
fprintf('Done!\n');