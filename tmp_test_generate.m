% tmp test for generating data

% [label, data] = syntheszie_data(2, 10, 2);
% plot(data1(:,1), data1(:,2), 'r+');
% hold on;
% plot(data2(:,1), data2(:,2), 'go');
% ccc = 0;
close all;
clc;

numClass = 5000;
numSamples = 11;
dim = 5;
[label, data, inter_s, intra_s] = syntheszie_data(numClass, numSamples, dim);

numSame = 3000;
numDiff = 3000;
[pair_same, pair_diff] = generate_pair(label, numSame, numDiff);

[A, G] = get_AG(inter_s, intra_s);
distance_same = sim_jointBayesian_syn(pair_same, data, label, A, G, 10);
distance_diff = sim_jointBayesian_syn(pair_diff, data, label, A, G, 10);
preJointSame = struct;
preJointDiff = struct;
[preJointSame.mean, preJointDiff.mean] = showCurve(distance_same.mean, distance_diff.mean, 'r.-', 2);
hold on;
[preJointSame.max, preJointDiff.max] = showCurve(distance_same.max, distance_diff.max, 'g.-', 2);
hold on;
[preJointSame.min, preJointDiff.min] = showCurve(distance_same.min, distance_diff.min, 'b.-', 2);
hold on;
distOur_same = sim_point_set_syn(pair_same, data, label, inter_s, intra_s, 10);
distOur_diff = sim_point_set_syn(pair_diff, data, label, inter_s, intra_s, 10);
[preOur_same, preOur_diff] = showCurve(distOur_same, distOur_diff, 'k.-', 2);
legend('mean', 'max', 'min', 'our');
ccc = 0;