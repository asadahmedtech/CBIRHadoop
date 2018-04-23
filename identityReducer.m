function identityReducer(key, intermValIter, outKVSTore)
% Reduce function for the Hue Saturation Value MapReduce example.

% Copyright 1984-2015 The MathWorks, Inc.


    % Loop over values for each key
    while hasnext(intermValIter)
        value = getnext(intermValIter);

        add(outKVSTore, key, value);

    end

    % Add final key-value pair
   
end
