function distance = sim_point_set_syn(pair, data, label, inter_s, intra_s, numPoints)
% distance = sim_point_set(pair, data, label, A, G)
%
% This function is used to compute the point to set distance we defined
% INPUT:
% pair : N by 2 matrix, each row contains the index of the pair
% data : data matrix, each row presents a data, data should be preprocessed
% label : label for each data
% inter_s, intra_s : used to compute the distance
% numPoints : number of points used in the set
% OUTPUT:
% distance : the similarity score for every pair of data

num = size(pair,1);
distance = zeros(num,1);


tvar = pinv(inter_s + intra_s);

[F, G] = inv_covriance(inter_s, intra_s, numPoints);
varData = (inter_s + intra_s) - numPoints*inter_s*(F + numPoints*G)*inter_s;
pvarData = pinv(varData);

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
    m = numPoints;
    tdata = tdata(1:numPoints,:);
    
    tmp = sum(tdata,1);
    meanData = (inter_s*(F + m*G)*tmp')';
    
%     distance(i) = 0.5*f1*tvar*f1' - 0.5*(f1 - meanData)*pvarData*(f1 - meanData)'...
%         + log(det(inter_s + intra_s)) - log(det(varData));
    
%     distance(i) = f1*tvar*f1' - (f1 - meanData)*pvarData*(f1 - meanData)'...
%         + log(det(inter_s + intra_s)) - log(det(varData));

    distance(i) = f1*tvar*f1' - (f1 - meanData)*pvarData*(f1 - meanData)';
end

end