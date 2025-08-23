%HW1-QUESTION 2


%function to calculate new median
function [newMedian]= UpdateMedian (oldMedian, NewDataValue, A, n)
    if mod(n,2)==0
       if NewDataValue <= A(n/2)
           newMedian=A(n/2);
       elseif NewDataValue >= A(n/2+1)
           newMedian=A(n/2+1);
       else 
           newMedian=NewDataValue;
       end
    else
       if NewDataValue <= A((n-1)/2)
           newMedian=(A((n-1)/2)+oldMedian)/2;
       elseif NewDataValue >= A((n+3)/2)
           newMedian=(A((n+3)/2)+oldMedian)/2;
       else 
           newMedian=(NewDataValue+oldMedian)/2;
       end
    end
end