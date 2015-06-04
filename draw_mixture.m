% draw curve
close all;
clc;

folderName = './';

figure;
load(strcat(folderName, 'mixture_intra_precision_dim_100_numGaussian_1.mat'));
load(strcat(folderName, 'mixture_extra_precision_dim_100_numGaussian_1.mat'));
plot(extra_precision, intra_precision, 'm-', 'LineWidth', 2);

hold on;

load(strcat(folderName, 'mixture_intra_precision_dim_100_numGaussian_2.mat'));
load(strcat(folderName, 'mixture_extra_precision_dim_100_numGaussian_2.mat'));
plot(extra_precision, intra_precision, 'b-', 'LineWidth', 2);

load(strcat(folderName, 'mixture_intra_precision_dim_100_numGaussian_3.mat'));
load(strcat(folderName, 'mixture_extra_precision_dim_100_numGaussian_3.mat'));
plot(extra_precision, intra_precision, 'k-', 'LineWidth', 2);

load(strcat(folderName, 'mixture_intra_precision_dim_100_numGaussian_4.mat'));
load(strcat(folderName, 'mixture_extra_precision_dim_100_numGaussian_4.mat'));
plot(extra_precision, intra_precision, 'g-', 'LineWidth', 2);

load(strcat(folderName, 'mixture_intra_precision_dim_100_numGaussian_5.mat'));
load(strcat(folderName, 'mixture_extra_precision_dim_100_numGaussian_5.mat'));
plot(extra_precision, intra_precision, 'r-', 'LineWidth', 2);

load(strcat(folderName, 'mixture_intra_precision_dim_100_numGaussian_10.mat'));
load(strcat(folderName, 'mixture_extra_precision_dim_100_numGaussian_10.mat'));
plot(extra_precision, intra_precision, 'c-', 'LineWidth', 2);

legend('num:1', 'num:2', 'num:3', 'num:4', 'num:5', 'num:10');
xlabel('compare for dim 100 with different number of Guassian','FontSize', 20);

