function [select_intra, select_extra] = select_pairs(pairlist_lfw, id_lfw, numSamples)
% [select_intra, select_extra] = select_pairs(pairlist_lfw, id_lfw, numSamples)
% This function is used to select pairs from the testing pair such that the
% selected testing pairs have the same number in the set
% INPUT:
% pairlist_lfw : the pairlist of original testing
% id_lfw : the label for each data
% numSamples : minimum samples in each set
% OUTPUT:
% select_intra : the selected intra pair
% select_extra : the selected extra pair

intra_pair = pairlist_lfw.IntraPersonPair;
extra_pair = pairlist_lfw.ExtraPersonPair;

intra_num = length(intra_pair);
extra_num = length(extra_pair);

select_intra = [];
select_extra = [];

count_intra = 0;
for i = 1 : intra_num
    f1 = intra_pair(i,1);
    f2 = intra_pair(i,2);
    
    l2 = id_lfw(f2);
    tindex = id_lfw == l2;
    if sum(tindex) >= (numSamples + 1)
        count_intra = count_intra + 1;
        select_intra(count_intra, 1) = f1;
        select_intra(count_intra, 2) = f2;
    end
end

count_extra = 0;
for i = 1 : extra_num
    f1 = extra_pair(i,1);
    f2 = extra_pair(i,2);
    l2 = id_lfw(f2);
    tindex = id_lfw == l2;
    if sum(tindex) >= numSamples
        count_extra = count_extra + 1;
        select_extra(count_extra, 1) = f1;
        select_extra(count_extra, 2) = f2;
    end
end

end