function [training_pro, projection, meanValue] = get_projection_PCA(training, dim)
% [training_pro, projection, meanValue] = get_projection_PCA(training, dim)
%
% this function is used to get the principle component using PCA
% INPUT:
% training: training data, each row contains an instance
% dim : the dimension of the projection
% OUTPUT:
% training_pro : training data after projection
% projection : projection matrix
% meanValue : mean value for the training data;

meanValue = mean(training);
cenData = training - repmat(meanValue, size(training,1), 1);
covData = cenData'*cenData;

% get the dim largest eigen vectors and eigen values
[V, D] = eig(covData);
tmpD = diag(D);
[~, I] = sort(tmpD, 'descend');
projection = V(:,I(1:dim));


%% Notice that each column of projection is a principle direction and each row of cenData is a centeralized instance
training_pro = cenData*projection;
end