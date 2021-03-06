function [precision_intra, precision_extra, best] = showCurve(intra_distance, extra_distance, line_format, line_width, varargin)
% [intra_precision, extra_precision] = showCurve(intra_distance, extra_distance, thr)
%
% function is used to draw the true positive and false positive curve
% INPUT : 
% intra_distance : similarity value for each instance in the positive set
% extra_distnace : similarity value for each instance in the negative set
% varargin : if not empty, it should have a vector contains all the possible threshold we want to try
% OUTPUT:
% intra_precision : output precision 
% extra_precision : input precision

minValue = min(min(intra_distance), min(extra_distance));
maxValue = max(max(intra_distance), max(extra_distance));
interValue = (maxValue - minValue)/200;

if length(varargin) == 1
    thr = varargin{1};
else
    thr = minValue:interValue: maxValue;
end

num = length(thr);

precision_intra = zeros(num,1);
precision_extra = zeros(num,1);

for i = 1 : num
    tmp1 = intra_distance > thr(i);
    precision_intra(i) = sum(tmp1)/size(intra_distance,1);
    tmp2 = extra_distance > thr(i);
    precision_extra(i) = sum(tmp2)/size(extra_distance,1);
end
plot(precision_extra, precision_intra, line_format, 'LineWidth', line_width);
best = max(precision_intra + 1 - precision_extra)/2;
end