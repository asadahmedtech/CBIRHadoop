% _____________JOB1_________________

setenv('HADOOP_HOME', '/home/nitw_viper_user/hadoop-2.7.2');
cluster = parallel.cluster.Hadoop;
cluster.HadoopProperties('mapred.job.tracker') = 'master:9008';
cluster.HadoopProperties('fs.default.name') = 'hdfs://master:9000';
disp(cluster);

% Change mapreduce execution environment to point to the remote cluster i.e
% Hadoop cluster
mapreducer(cluster);


seqFolder = 'hdfs://master:9000/';

 demoFolder1 = fullfile(seqFolder, 'corel_lbp_1K');

ds = imageDatastore({demoFolder1},'FileExtensions', {'.jpg'}); 

output_seq='hdfs://master:9000/test/Corel_1bp_1K_seq';
seqds=mapreduce(ds,@identityMapper,@identityReducer,'OutputFolder',output_seq);
 
% _____________JOB2_________________

OutputFolder_1 = 'hdfs://master:9000/test/corel_1K_lbp_fv';
res = mapreduce(seqds, @lbp_db1_seq_file_mapper, @lbp_db1_reducer, 'OutputFolder', OutputFolder_1);


% _____________JOB3_________________

t = readall(res);

%Getting the Feature Vector of the Query Image
qpath = 'hdfs://master:9000/corel_lbp_1K/354.jpg';
OutputFolder_2 = 'hdfs://master:9000/test/corel_1K_lbp_qm';
ind = find(ismember(t.Key,qpath));
vec1 = t.Value{ind};


mapperfun = @(data,Info,interim) similarityMeasurement_Mapper(data, vec1, interim);

retrieval_res = mapreduce(res,mapperfun,@similarityMeasurement_Reducer,'OutputFolder', OutputFolder_2);

t1 = readall(retrieval_res);

path = t1.Value(1);
idx = find(strcmp(ds.Files, path));
figure,imshow(readimage(ds, idx)); %Displaying the quey imges

%Displaying the top-10 matched images
figure,
for i = 1:10      
     path = t1.Value(i);
    idx = find(strcmp(ds.Files, path));
    %figure,
  subplot(2,5,i) ,  imshow(readimage(ds, idx))
  %  title(ind);
end