function similarityMeasurement_Mapper(data, info, intermKVStore)
% Map function for the Hue Saturation Value MapReduce example.

% Copyright 1984-2015 The MathWorks, Inc.

vec1 = info;
task_size = size(data.Key,1);
dist_array = zeros(size(data.Key,1),1);
for i = 1 : size(data.Key,1)
    vec2 = data.Value{i};
    dist = 0.0;
    % change the distance measure
    %for i = 1 : size(vec1,1)
     %  dist =  dist + abs( (vec1(i) - vec2(i))/(1+ vec1(i) + vec2(i)));
    %end
    for j = 1 : size(vec1,1)
      dist =  dist + (vec1(j) - vec2(j)) * (vec1(j) - vec2(j));
    end
    dist = sqrt(dist);
    dist_array(i) = dist;
end
if task_size <= 20
    %write key-dist value - struct of dist and filename
    for i = 1 : size(data.Key,1)
        path = data.Key{i};
        value = struct('filename',path,'distance',dist_array(i));
        add(intermKVStore, 'distance', value);
    end
    
else
    %write only top 20
    [dist_array , indices] = sort(dist_array);

    for i = 1 : 20 
        path = data.Key{indices(i)};
        value = struct('filename',path,'distance',dist_array(indices{i}));
        add(intermKVStore, 'distance', value);
        %write dist n filename 
    end

end



end
