function distance = sim_jointBayesian_1(pair, data, label, A, G)
% distance = sim_point_set(pair, data, label, A, G)
%
% This function is used to compute the point to set distance we defined
% INPUT:
% pair : N by 2 matrix, each row contains the index of the pair
% data : data matrix, each row presents a data, data should be preprocessed
% label : label for each data
% inter_s, intra_s : used to compute the distance
% OUTPUT:
% distance : the similarity score for every pair of data

num = size(pair,1);
distance.mean = zeros(num,1);
distance.min = zeros(num,1);
distance.max = zeros(num,1);
distance.normal = zeros(num,1);


for i = 1 : num
    i1 = pair(i,1);
    i2 = pair(i,2);
    f1 = data(i1,:);
    f2 = data(i2,:);
    
    % finding the labels for each person
    l1 = label(i1);
    l2 = label(i2);
    tind = label == l2;
    
    % if l1 and l2 are the same person, remove l1
    if l1 == l2
        tind(i1) = 0;
    end
    
    tdata = data(tind,:);
    m = size(tdata,1);
    if m > 20
        tdata = tdata(1:20,:);
        m = 20;
    end
    
    tmp = repmat(f1*A*f1', m,1) + diag(tdata*A*tdata') - 2*(f1*G*tdata')';
    distance.mean(i) = mean(tmp);
    distance.min(i) = min(tmp);
    distance.max(i) = max(tmp);
    distance.normal(i) = f1*A*f1' + f2*A*f2' - 2*f1*G*f2';
end

end