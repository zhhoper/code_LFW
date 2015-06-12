function gmmJoint = get_joint(gmmSingle, inter_s)
% gmmModel = get_joint(gmm1)
% 
% this function is used to fit a joint probability of two random variables
% which all gmmSingle
% INPUT:
% gmmSingle : the gmm model for single variable
% inter_s : use to fit joint gaussian
% OUTPUT:
% gmmJoint : the gmm modle for joint 

numGauss = gmmSingle.NComponents;
dim = gmmSingle.NDimensions;

mu = zeros(numGauss^2, 2*dim);
prob = zeros(1, numGauss*numGauss);
sig = zeros(2*dim, 2*dim, numGauss*numGauss);

count = 1;
for i = 1 : numGauss
    for j = 1 : numGauss
        mu(count, :) = [gmmSingle.mu(i,:), gmmSingle.mu(j,:)];
        prob(count) = gmmSingle.PComponents(i) * gmmSingle.PComponents(j);
        sig(:,:,count) = [gmmSingle.Sigma(:,:,i), inter_s; inter_s, gmmSingle.Sigma(:,:,j)];
        count = count + 1;
    end
end

gmmJoint = gmdistribution(mu, sig, prob);
