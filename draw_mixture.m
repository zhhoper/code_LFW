% draw curve
close all;
clc;

folderName = './';

figure;
load(strcat(folderName, 'mixture_intra_precision_dim_200_numGaussian_1.mat'));
load(strcat(folderName, 'mixture_extra_precision_dim_200_numGaussian_1.mat'));
b1 = max((intra_precision - extra_precision + 1)/2)*100
plot(extra_precision, intra_precision, 'm-', 'LineWidth', 2);

hold on;

load(strcat(folderName, 'mixture_intra_precision_dim_200_numGaussian_2.mat'));
load(strcat(folderName, 'mixture_extra_precision_dim_200_numGaussian_2.mat'));
b2 = max((intra_precision - extra_precision + 1)/2)*100
plot(extra_precision, intra_precision, 'b-', 'LineWidth', 2);

load(strcat(folderName, 'mixture_intra_precision_dim_200_numGaussian_3.mat'));
load(strcat(folderName, 'mixture_extra_precision_dim_200_numGaussian_3.mat'));
b3 = max((intra_precision - extra_precision + 1)/2)*100
plot(extra_precision, intra_precision, 'k-', 'LineWidth', 2);

load(strcat(folderName, 'mixture_intra_precision_dim_200_numGaussian_4.mat'));
load(strcat(folderName, 'mixture_extra_precision_dim_200_numGaussian_4.mat'));
b4 = max((intra_precision - extra_precision + 1)/2)*100
plot(extra_precision, intra_precision, 'g-', 'LineWidth', 2);

load(strcat(folderName, 'mixture_intra_precision_dim_200_numGaussian_5.mat'));
load(strcat(folderName, 'mixture_extra_precision_dim_200_numGaussian_5.mat'));
b5 = max((intra_precision - extra_precision + 1)/2)*100
plot(extra_precision, intra_precision, 'r-', 'LineWidth', 2);

load(strcat(folderName, 'mixture_intra_precision_dim_200_numGaussian_10.mat'));
load(strcat(folderName, 'mixture_extra_precision_dim_200_numGaussian_10.mat'));
b6 = max((intra_precision - extra_precision + 1)/2)*100
plot(extra_precision, intra_precision, 'c-', 'LineWidth', 2);

l1 = sprintf('num:1, p: %.2f%%', b1);
l2 = sprintf('num:2, p: %.2f%%', b2);
l3 = sprintf('num:3, p: %.2f%%', b3);
l4 = sprintf('num:4, p: %.2f%%', b4);
l5 = sprintf('num:5, p: %.2f%%', b5);
l6 = sprintf('num:10, p: %.2f%%', b6);
legend(l1, l2, l3, l4, l5, l6);
xlabel('compare for dim 100 with different number of Guassian','FontSize', 20);

