path = '../pgms/test1/image.orig';
%path = 'Images';
demofolder = fullfile(path);
ds = datastore({demofolder}, 'Type', 'image', 'FileExtensions', {'.jpg', '.gif', '.png'});
%disp(ds);
res_seq_file = mapreduce(ds, @identityMapper, @identityReducer, 'OutputFolder', 'db1_seq_file');

% to search for the index of query image with its filename as key value

%ind = find(ismember(t.Key,'/Users/srimaharaj/Documents/MATLAB/LtrpHadoop/Images/0.jpg'))
% t.Value{ind}
%can access the vector of query image now
                        %but
% how to add the value of query image to each and every key  



%/Users/srimaharaj/Documents/MATLAB/pgms
%/Users/srimaharaj/Documents/MATLAB/pgms/test1/image.orig

%normal retrival demo