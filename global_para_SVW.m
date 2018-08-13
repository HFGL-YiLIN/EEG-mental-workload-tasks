%% set up      
global cardColor
cardColor={'d', 'b', 'p', 'q'};
global card_color_1
card_color_1 = {'=', '-', '|', '||'};
global correctAnsdb
correctAnsdb = cell(0);
global trial_nth
trial_nth = 1;
global trial_idx 
trial_idx = 1; 
global accuracy
accuracy = zeros(1, 333);
global totalacc;
totalacc = 0;
global totaltrials
totaltrials = 0;
global rt
rt = zeros(1, 333);
global rt_co
rt_co = zeros(1, 333);
global totalrt;
totalrt = 0;
global totaltrials_co
totaltrials_co = zeros(1, 333);
global totaltrials_inco
totaltrials_inco = zeros(1, 333);

%% modify as tasks 
global t1
t1 = 0.5; % TBR
global t2
t2 = 2.5; % R 
global t3 
t3 = 0.66;
global cardNum
cardNum = 6; % button # 
global trialNum
trialNum = 81; 

global rest 
rest = 30;
global pc_user 
pc_user = 'mitsu_gtec'; 
global modelName
modelName = 'EyeClosed';