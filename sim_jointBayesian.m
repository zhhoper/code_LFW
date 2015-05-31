function distance = sim_jointBayesian(pair, data, A, G)
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
    i1 = pair(i,1);
    i2 = pair(i,2);
    f1 = data(i1,:);
    f2 = data(i2,:);
    distance(i) = f1*A*f1' + f2*A*f2' - 2*f1*G*f2';
end

end