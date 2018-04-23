function identityMapper(data, info, intermKVStore)
% Map function for the Hue Saturation Value MapReduce example.

% Copyright 1984-2015 The MathWorks, Inc.
    add(intermKVStore, info.Filename, data);
end
