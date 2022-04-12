% lgraph = vgglgraph(inputSize, outputSize, convstages, fcstates, outputtype) 
% creates a layer graph in the stype of VGG
%
% SD, 29/01/2020
% This is based on the residual version, and is here to save writing (or
% copying and pasting) networks between scripts
%
% Parameters:
% - inputSize is the size of the input to the network
% - outputSize is the size of the output, this is provided as a single
% number, as the function assumes that the network output is a 1xoutputSize
% vector
% - convstages is a list of numbers that represent the number of filters in
% each convolutional stage. For each stage a block that consists of a
% conv2D, relu, conv2D, batchNorm, and relu will be created. The number of
% filters in the two conv2D layers will be the same
% - fcstages, is a list of numbers that represent the number of activations
% in a fully connected layer. For each stage, a blocks that contains a FC, 
% a batchNorm, a relu and a dropout will be created. The last fcstage will
% be followed by another fully connected layer which takes it size from
% outputSize
% - outputType is either "classification" or "regression", and determines
% what the final activation and loss are. If anything else is specified,
% then no loss layer will be created (handy for siamese networks)
% 
% Example: lgraph = vgglgraph([32 32 3], 10, [8, 16, 32], [256], "classification") 
% creates a vgg style graph for CIFAR-10 data (or similar) that has 6 
% conv2d layers, a 256 dim FC layer, a 10 dim output layer with a softmax
% and categorical cross entropy loss
%
% For those looking at this and wondering why it looks so much simpler than
% the ResNet one, it's becuase ResNet has skip connections, and this
% doesn't. For that reason layer names are not needed here, but are
% included to make adding/removing layers for fine-tuning easier (if that's
% something you want to do).
%

function lgraph = vgglgraph(inputsize, outputsize, convstages, fcstages, outputtype)
    layers = [
        imageInputLayer(inputsize,'Name','input')];

    for i=1:length(convstages)
        name = sprintf('convblock_%d_', i);
        layers = [layers
            convstage(convstages(i), name)];
    end
    
    for i=1:length(fcstages)
        name = sprintf('fcblock_%d_', i);
        layers = [layers
            fcstage(fcstages(i), name)];
    end
    
    layers = [layers,
        fullyConnectedLayer(outputsize, 'Name', 'fcFinal')];
    
    if (outputtype == "classification")
        layers = [layers,
            softmaxLayer('Name','softmax')
            classificationLayer('Name','classoutput')];            
    elseif (outputtype == "regression")
        layers = [layers,
            regressionLayer('Name','regoutput')];
    end
    
    lgraph = layerGraph(layers);
end

function layers = convstage(kernels, tag) 
    layers = [
        convolution2dLayer(7, kernels, 'Padding', 'Same', 'Name', [tag 'C1']),
        reluLayer('Name',[tag,'relu1']),
        convolution2dLayer(5, kernels, 'Padding', 'Same', 'Name', [tag 'C2']),
        batchNormalizationLayer('Name',[tag,'BN1'])
        reluLayer('Name',[tag,'relu2']),
        maxPooling2dLayer(2, 'Stride', 2, 'Name', [tag, 'Pool'])];
end

function layers = fcstage(size, tag)
    layers = [
        fullyConnectedLayer(size, 'Name', [tag, 'FC']),        
        batchNormalizationLayer('Name',[tag,'BN1'])
        reluLayer('Name',[tag,'relu1']),
        dropoutLayer(0.5, 'Name', [tag, 'DO'])];        
end