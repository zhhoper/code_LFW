function distance = sim_point_set_1(pair, data, label, inter_s, intra_s)
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
distance = zeros(num,1);

allF = struct;
allG = struct;
all_varData = struct;
all_pvarData = struct;
tvar = pinv(inter_s + intra_s);

numFaces = 20;
for i = 1 : numFaces
    [allF(i).data, allG(i).data] = inv_covriance(inter_s, intra_s, i);
    all_varData(i).data = (inter_s + intra_s) - i*inter_s*(allF(i).data + i*allG(i).data)*inter_s;
    all_pvarData(i).data = pinv(all_varData(i).data);
end


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
    m = size(tdata,1);
    if m > 20
        tdata = tdata(1:20,:);
        m = 20;
    end
    F = allF(m).data;
    G = allG(m).data;
    varData = all_varData(m).data;
    pvarData = all_pvarData(m).data;
    
    tmp = sum(tdata,1);
    meanData = (inter_s*(F + m*G)*tmp')';
    
    distance(i) = 0.5*f1*tvar*f1' - 0.5*(f1 - meanData)*pvarData*(f1 - meanData)'...
        + log(det(inter_s + intra_s)) - log(det(varData));
    
%     distance(i) = f1*tvar*f1' - (f1 - meanData)*pvarData*(f1 - meanData)'...
%         + log(det(inter_s + intra_s)) - log(det(varData));
    
end

end