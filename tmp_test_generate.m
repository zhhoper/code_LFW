% this is the test file for synthesic data

close all;
clc;

numClass = 5000;   % number of class
numSamples = 11;   % number of samples for each class
dim = 15;           % dimension of each data

% generate data
s_inter = 1;
s_intra = 2;
[label, data, inter_s, intra_s] = syntheszie_data(numClass, numSamples, dim, s_inter, s_intra);

numSame = 3000;    % number of same pair
numDiff = 3000;    % number of different pair

% generate testing pair
[pair_same, pair_diff] = generate_pair(label, numSame, numDiff);

% Computing the distance using naiive method
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

% Computing the distance using posterior distribution
distOur_same = sim_point_set_syn(pair_same, data, label, inter_s, intra_s, 10);
distOur_diff = sim_point_set_syn(pair_diff, data, label, inter_s, intra_s, 10);
[preOur_same, preOur_diff] = showCurve(distOur_same, distOur_diff, 'k.-', 2);
legend('mean', 'max', 'min', 'our');
xlabel(sprintf('Dim: %d; Samples: %d; numClass: %d, numData: %d, s_inter: %d, s_intra: %d', dim, numSame+numDiff, numClass, numSamples, s_inter, s_intra));