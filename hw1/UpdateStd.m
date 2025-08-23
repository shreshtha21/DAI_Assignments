%HW1-QUESTION 2

%function to calculate new standard deviation
function newStd = UpdateStd (OldMean, OldStd, NewMean, NewDataValue, n)
    oldsumsquare=(n-1)*OldStd^2 + n*OldMean^2;
    newvariance=(oldsumsquare + (NewDataValue^2) - (n+1)*NewMean^2)/n;
    newStd = sqrt(newvariance);
end