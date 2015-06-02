function [pair_same, pair_diff] = generate_pair(label, numSame, numDiff)
% generate_pair(label, numSame, numDiff)
% this function is used to generate pairs for testing
% label : input labels
% numSame : number of same pairs
% numDiff : number of different pairs

totalNum = length(label);
pair_same = randperm(totalNum, numSame)';
pair_same = [pair_same, pair_same];

pair_diff = zeros(numDiff,2);
pair_diff(:,1) = randperm(totalNum, numDiff);
tmp_diff = randperm(totalNum, numDiff);

for i = 1 : numDiff
    if label(pair_diff(i,1)) ~= tmp_diff(i)
        pair_diff(i,2) = tmp_diff(i);
    else
        tmp = randi(totalNum, 1);
        while tmp == pair_diff(i,1)
            tmp = randi(totalNum,1);
        end
        pair_diff(i,2) = tmp;
    end
end

end