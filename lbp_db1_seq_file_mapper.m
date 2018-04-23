function lbp_db1_seq_file_mapper(data, ~, intermKVStore)
% Map function for the Hue Saturation Value MapReduce example.

% Copyright 1984-2015 The MathWorks, Inc.
   for i  = 1: size(data.Key,1)
        im=data.Value{i};
        if size(im,3)==3
            gray=rgb2gray(im);
        else
            gray=im;
        end
       % gray = rgb2gray(data.Value{i});
        vect = get_feature_vector_lbp(gray); 

        % Add intermediate key-value pairs
        add(intermKVStore,data.Key{i} , vect);
    end
end
