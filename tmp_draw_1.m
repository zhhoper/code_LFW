% draw curve
close all;
clc;


figure;
load('intra_precision_100.mat');
load('extra_precision_100.mat');
plot(extra_precision.normal, intra_precision.normal, 'b-', 'LineWidth', 2);

hold on;
plot(extra_precision.max, intra_precision.max, 'k+-', 'LineWidth', 2);
hold on;
plot(extra_precision.min, intra_precision.min, 'm-', 'LineWidth', 2);
hold on;
plot(extra_precision.mean, intra_precision.mean, 'k-', 'LineWidth', 2);

hold on;
load('p_s_intra_precision_100.mat');
load('p_s_extra_precision_100.mat');
plot(p_s_extra_precision, p_s_intra_precision, 'r-', 'LineWidth', 2);

hold on;
load('p_s_intra_precision_correct_100.mat');
load('p_s_extra_precision_correct_100.mat');
plot(p_s_extra_precision, p_s_intra_precision, 'g-', 'LineWidth', 2);

legend('normal', 'max', 'min', 'mean', 'joint', 'joint correct');
title('dim 100','FontSize', 20);

