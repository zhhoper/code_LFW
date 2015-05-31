% draw curve
close all;
clc;

figure;
load('intra_precision_2000.mat');
load('extra_precision_2000.mat');
plot(extra_precision, intra_precision, 'b-', 'LineWidth', 2);

hold on;
load('intra_precision_100.mat');
load('extra_precision_100.mat');
plot(extra_precision.normal, intra_precision.normal, 'k-', 'LineWidth', 2);

hold on;
plot(extra_precision.max, intra_precision.max, 'k*-', 'LineWidth', 2);

hold on;
load('p_s_intra_precision_100.mat');
load('p_s_extra_precision_100.mat');
plot(p_s_extra_precision, p_s_intra_precision, 'r-', 'LineWidth', 2);

hold on;
load('p_s_intra_precision_correct_100.mat');
load('p_s_extra_precision_correct_100.mat');
plot(p_s_extra_precision, p_s_intra_precision, 'g-', 'LineWidth', 2);

legend('normal dim 2000', 'normal dim 100', 'max dim 100', 'joint 100', 'joint correct 100');
title('compare','FontSize', 20);

