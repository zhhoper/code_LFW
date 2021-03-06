function distance = sim_jointBayesian_joint_mixture(pair, data, gmmModel, intra_s)
% distance = sim_jointBayesian(pair, A, G)
%
% this function is used to compute the similarity score for a pair of data
% using the method provided by joint bayesian paper
% INPUT:
% pair : N by 2 matrix, each row contains the index of the pair
% data : data matrix, each row presents a data, data should be preprocessed
% A, G : used to compute the distance
% OUTPUT:
% distance : the similarity score for every pair of data
num = size(pair,1);
distance = zeros(num,1);

for i = 1 : num
    %tic
    i1 = pair(i,1);
    i2 = pair(i,2);
    f1 = data(i1,:);
    f2 = data(i2,:);
%     l1 = cluster(intra, f1);
%     l2 = cluster(intra, f2);
%     sig1 = intra.Sigma(:,:,l1);
%     sig2 = intra.Sigma(:,:,l2);
%     mean1 = intra.mu(l1,:);
%     mean2 = intra.mu(l2,:);
%     cov1 = [sig1, inter_s; inter_s, sig2];
%     cov2 = [sig1, zeros(size(inter_s)); zeros(size(inter_s)), sig2];
%     d1 = eig(cov1);
%     d2 = eig(cov2);
%     pcov1 = pinv(cov1);
%     pcov2 = pinv(cov2);
%     %distance(i) = f1*A*f1' + f2*A*f2' - 2*f1*G*f2';
%     feature = [f1 - mean1, f2 - mean2];
    f = [f1, f2];
    p = pdf(gmmModel, f);
    p1 = pdf(intra_s, f1);
    p2 = pdf(intra_s, f2);
    distance(i) = log(p1) + log(p2) - log(p);
    %distance(i) = feature*(pcov2 - pcov1)*feature' + sum(log(d2)) - sum(log(d1));
    %distance(i) = feature*(pcov2 - pcov1)*feature';
    %toc
    %ccc = 0;
end

end