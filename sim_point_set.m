function distance = sim_point_set(pair, data, label, inter_s, intra_s, numSamples)
% distance = sim_point_set(pair, data, label, A, G)
% 
% This function is used to compute the point to set distance we defined. We
% suppose the number of sample points in each testing set is the same so we
% don't need to compute the determinant.
% INPUT:
% pair : N by 2 matrix, each row contains the index of the pair
% data : data matrix, each row presents a data, data should be preprocessed
% label : label for each data
% inter_s, intra_s : used to compute the distance
% numSamples : number of samples in the set
% OUTPUT:
% distance : the similarity score for every pair of data

num = size(pair,1);
distance = zeros(num,1);

[F, G] = inv_covriance(inter_s, intra_s, numSamples);
varData = inter_s + intra_s - numSamples*inter_s*(F + numSamples*G)*inter_s;

pvarData = pinv(varData);
tvar = pinv(inter_s + intra_s);

for i = 1 : num
    i1 = pair(i,1);
    i2 = pair(i,2);
    f1 = data(i1,:);
    %f2 = data(i2,:);
    
    % finding the labels for each person
    l1 = label(i1);
    l2 = label(i2);
    tind = label == l2;
    
    % if l1 and l2 are the same person, remove l1
    if l1 == l2
        tind(i1) = 0;
    end
    
    tdata = data(tind,:);
    m = numSamples;
    tdata = tdata(1:m,:);
    tmp = sum(tdata,1);
    meanData = (inter_s*(F + m*G)*tmp')';

    distance(i) = f1*tvar*f1' - (f1 - meanData)*pvarData*(f1 - meanData)';

end

end