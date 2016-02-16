% [BLOODLUST] Machine Learning Anomaly IDS 
% Copyright (C) 2011 BareMetal Networks Corporation
% 07-24-11 
sprintf('\n');
disp '********************************************************************'
disp '*************************** [BLOODLUST] ****************************'
disp '********************************************************************'
disp '* BMN Machine Learning Anomaly IDS                                 *'
disp '* Copyright (C) 2011 BareMetal Networks Corporation                *'
disp '********************************************************************'
sprintf('\n');

disp '* RESTRICTED -- EYES ONLY -- CORPORATE TRADE SECRETS               *' 
disp '* DISCLOSURE OF ANY MATERIAL HEREIN IS ILLEGAL                     *'
disp '* VIOLATORS WILL BE PUNISHED TO THE FULL EXTENT OF THE LAW         *'
disp '********************************************************************'
disp '********************************************************************'
sprintf('\n');

format long

if  ~exist('mal')
   disp '[DATASET] - No dataset detected'   
   dsfilename = '~/datasets/training-01.dat';
   disp(['[DATASET] - Loading ', dsfilename])
   

    fid = fopen(dsfilename,'r');
    i = 0;
   
    while ~feof(fid)
        i = i+1;
        tr01.textdata(i) = textscan(fid, '%s', 9, 'Delimiter', ',', ...
            'EndOfLine', '\n', 'CollectOutput', 0);
        tr01.data(i) = textscan(fid, '%n', 13, 'Delimiter', ',', ...
            'EndOfLine', '\n', 'CollectOutput', 0);
    end
    fclose(fid);
    
end

% strip out wanted data
tset = [tr01.data{1,:}];

% OMGWTFBBQNORMALIZER
tset(1, :)  = atan((tset(1, :) - mean(tset(1,:))) / std(tset(1,:)));
tset(2, :)  = atan((tset(2, :) - mean(tset(2,:))) / std(tset(2,:)));
tset(3, :)  = atan((tset(3, :) - mean(tset(3,:))) / std(tset(3,:)));
tset(4, :)  = atan((tset(4, :) - mean(tset(4,:))) / std(tset(4,:)));
tset(5, :)  = atan((tset(5, :) - mean(tset(5,:))) / std(tset(5,:)));
tset(6, :)  = atan((tset(6, :) - mean(tset(6,:))) / std(tset(6,:)));
tset(7, :)  = atan((tset(7, :) - mean(tset(7,:))) / std(tset(7,:)));
tset(8, :)  = atan((tset(8, :) - mean(tset(8,:))) / std(tset(8,:)));
tset(9, :)  = atan((tset(9, :) - mean(tset(9,:))) / std(tset(9,:)));
tset(10, :)  = atan((tset(10, :) - mean(tset(10,:))) / std(tset(10,:)));
tset(11, :)  = atan((tset(11, :) - mean(tset(11,:))) / std(tset(11,:)));
tset(12, :)  = atan((tset(12, :) - mean(tset(12,:))) / std(tset(12,:)));

bstate = struct;
bstate.max = max(max(tset));
bstate.min = min(min(tset));
% bstate.dims = size(tset) - 1;
% DIM TIME FP FN ITER PERF GRAD 
% 1 01:43 2.9% 3.5% 0.0426 0.0153 UNIENTR        2.8% 3.2% 200 0.0387 0.00154 6 UNIENTR
% 2 04:18 0.8% 1.6% 0.0191 0.00123 265 BIGENTR    03:32 0.9% 1.6%  0.02215 0.00126 BIENTRO
% 3 03:11 0.3% 0.3% 176 0.00463 0.00220 PRPMFC
% 4 05:05 0.1% 0.1% 0.00312 0.0372 6 PRPMFBIG
% NUMPRINT
% NUMNOPRINT
% PROPPRINT
% PROPNOPRINT
% NUMZEROS
% 10 06:37 0.0% 0.0% 110 0.000302 0.000234 PROPZEROS
% 11 05:54 0.0% 0.0% 100 0.000441 0.000822 NUMMFC
% 12 02:15 0.1% 0.2% 31 0.00162 0.00134 NUMMFBIGRAM

bstate.dims = 2;
disp (['[DATASET] - ', bstate.dims, ' Dimensions']);
disp (['[DATASET] -  MIN ', bstate.min, ' MAX ', bstate.max]);
    

%tset(1, :) = 

%textdata = [tr01.textdata{1,:}];

% free the unused mem
tr01 = []; 


%blood = network;
%blood = feedforwardnet;
blood = patternnet(20, 'trainlm');
blood.name = 'Bloodlust';
% INPUTS
blood.numInputs = 1;         % set input layers to 1, no one uses >1
blood.inputs{1}.size = bstate.dims;   % 12 dimensions of input


% LAYERS
% 2 extra layers, 1 hidden w/80 neurons, 1 output w/1 neuron
blood.numLayers = 2;
blood.layers{1}.size = 80;
blood.layers{2}.size = 1;

blood.inputConnect(1) = 1;  % define layer inputs are connected to
blood.layerConnect(2, 1) = 1;
blood.outputConnect(2) = 1;
%blood.targetConnect(2) = 1 ;

blood.layers{1}.transferFcn = 'logsig';
blood.layers{2}.transferFcn = 'purelin';

%net.biasConnect = [1; 1];
disp '[NEURAL]  - Bloodlust artificial neural network is ONLINE.'

% INIT
blood.initFcn = 'initlay';

% mean absolute error - for classification, use mse for function approx
% blood.performFcn = 'mae';    
disp(['[NEURAL]  - Performance function: ', blood.performFcn]);

% go pro - repmat the 0-1 range out for each dimension of input                            
blood.inputs{1}.range = repmat([bstate.min bstate.max], [bstate.dims, 1]);


% TRAINING                            
% blood.trainFcn = 'trainlm';  % levenberg-marqardt
% blood.trainParam.lr = 0.1;    % learning rate
% blood.trainParam.mc = 0.9;      % momentum term
% disp '[NEURAL]  - Training parameters set';
%train(net, input, target)

disp '[NEURAL]  - Training now...'
% tset(1:12) is data, 13 is target
[blood, tr] = train(blood, tset(1:bstate.dims, :),  tset(13, :));


%  view(blood)
 y = blood(tset(1:bstate.dims, :));
 perf = perform(blood,y,tset(13, :));
 classes = vec2ind(y);
plotconfusion
% bentropy = tset(1, 1:end);
% uentropy = tset(2, 1:end);
% tr01.data = [];
% tr01.data = [];
%tset(10, 2) % the 10th element of the 2nd sample
%tset(12,1) % 12 dimensions to the data
