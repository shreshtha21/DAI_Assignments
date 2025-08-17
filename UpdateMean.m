%HW1-QUESTION 2

%function to calculate new mean
function [newMean]=UpdateMean(OldMean, NewDataValue, n)
    newMean=((OldMean*n)+NewDataValue)/(n+1);
end