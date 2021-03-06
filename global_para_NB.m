%% set up      
global cardColor
cardColor = {'C', 'H', 'K', 'L', 'Q', 'R', 'S', 'T'};
global correctAnsdb
correctAnsdb = cell(0);
global trial_nth
trial_nth = 1;
global acc_nth
acc_nth = 1; 
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

%% modify as task 
global t1
t1 = 0.5; % TBR
global t2
t2 = 2.5; % R 
global t3
t3 = 0.68;
global cardNum
cardNum = 8; % not button # n trails per row 
global trialNum
trialNum = 81; 
global trialNum_dbplus 
trialNum_dbplus = trialNum + 3;

global rest 
rest = 30;
global pc_user 
pc_user = 'mitsu_gtec'; 
global modelName 
modelName = 'EyeClosed';