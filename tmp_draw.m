% draw curve
close all;
clc;

folderName = 'wrong_mat/';

figure;
load(strcat(folderName, 'intra_precision_2000.mat'));
load(strcat(folderName, 'extra_precision_2000.mat'));
plot(extra_precision.normal, intra_precision.normal, 'm-', 'LineWidth', 2);

hold on;
plot(extra_precision.mean, intra_precision.mean, 'b-', 'LineWidth', 2);

hold on;
plot(extra_precision.max, intra_precision.max, 'k-', 'LineWidth', 2);

hold on;
plot(extra_precision.min, intra_precision.min, 'g-', 'LineWidth', 2);

hold on;
load(strcat(folderName, 'p_s_intra_precision_2000.mat'));
load(strcat(folderName, 'p_s_extra_precision_2000.mat'));
plot(p_s_extra_precision, p_s_intra_precision, 'r-', 'LineWidth', 2);


legend('normal', 'mean', 'max', 'min', 'our');
xlabel('compare for dim 2000','FontSize', 20);

