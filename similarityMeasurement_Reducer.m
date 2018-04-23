
function similarityMeasurement_Reducer(key, intermValIter, outKVSTore)
% Reduce function for the Hue Saturation Value MapReduce example.

% Copyright 1984-2015 The MathWorks, Inc.

i = 1;

    % Loop over values for each key
    while hasnext(intermValIter)
        value = getnext(intermValIter);
        %dind min 20 of all these
        dist_array(i) = value.distance;
        filename{i} = value.filename;

        i = i + 1;
    end
    filename = filename';
    dist_array = dist_array';
    
    [dist_array , indices] = sort(dist_array);

    for i = 1 : 20 
        path = filename{indices(i)};
        add(outKVSTore, i, path);
        % key - rank and value - filename
        %write dist n filename 
    end
    % Add final key-value pair
   
end
