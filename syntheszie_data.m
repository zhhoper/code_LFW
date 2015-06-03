function [label, data, inter_s, intra_s] = syntheszie_data(numClass, numSamples, dim, s_inter, s_intra)
% [label, data] = syntheszie_data(numClass, numSamples, dim)
% this function is used to generate data and label
% numClass : number of classes
% numSamples : number of samples for each class
% dim : number of dim

%% generate inter class variance
rng(5000);
eigValue1 = rand(dim,1) * s_inter ;
vec1 = zeros(dim, dim);
for i = 1 : dim
    rng(5000 + i*20);
    tmp = rand(dim,1);
    if i == 1
        vec1(:,i) = tmp / norm(tmp);
    else
        % orthogonalize the generated data
        tmpVec = vec1(:, 1:i-1);
        tmp = tmp - tmpVec*(tmpVec'*tmp);
        tmp = tmp / norm(tmp);
        vec1(:,i) = tmp;
    end
end
inter_s = vec1*diag(eigValue1)*vec1';

%% generate intra class variance
rng(10000);
eigValue2 = rand(dim,1) * s_intra;
vec2 = zeros(dim, dim);
for i = 1 : dim
    rng(10000 + i*20);
    tmp = rand(dim,1);
    if i == 1
        vec1(:,i) = tmp / norm(tmp);
    else
        % orthogonalize the generated data
        tmpVec = vec2(:, 1:i-1);
        tmp = tmp - tmpVec*(tmpVec'*tmp);
        tmp = tmp / norm(tmp);
        vec2(:, i) = tmp;
    end
end
intra_s = vec2*diag(eigValue2)*vec2';

[label, data] = generate_data(inter_s, intra_s, numClass, numSamples);
end
