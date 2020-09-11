clc;
clear;
imagepath = fullfile('Training');
imdsTrain = imageDatastore(imagepath,'IncludeSubfolders',true,'LabelSource','Foldernames');

labelCount = countEachLabel(imdsTrain);histogram(imdsTrain.Labels);title('Class frequency');
labels=imdsTrain.Labels;
[G,classes] = findgroups(labels);
numObservations = splitapply(@numel,labels,G);
desiredNumObservationsPerClass = max(numObservations);
files = splitapply(@(x){randReplicateFiles(x,desiredNumObservationsPerClass)},imdsTrain.Files,G);
files = vertcat(files{:});

%%
labels=[];info=strfind(files,'\');
for i=1:numel(files)
    idx=info{i};
    dirName=files{i};
    targetStr=dirName(idx(end-1)+1:idx(end)-1);
    targetStr2=cellstr(targetStr);
    labels=[labels;categorical(targetStr2)];
end
imdsTrain.Files = files;
imdsTrain.Labels=labels;
labelCount_oversampled = countEachLabel(imdsTrain)
histogram(imdsTrain.Labels)

title('Class frequency');
%%
