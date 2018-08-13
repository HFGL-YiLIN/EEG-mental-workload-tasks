%% set up      
global cardColor
cardColor={'d', 'b', 'p', 'q'};
global card_color_1
card_color_1 = {'=', '-', '|', '||', '=|', '|=', '=||', '||='};
global correctAnsdb
% correctAnsdb = cell(0);
global monitorAnsdb
global trial_nth
trial_nth = 1;
global trial_idx 
trial_idx = 1; % start in control_test, only for the 1st trail data 
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

% modify as task  

global trialNum
trialNum = 555; 
global margin_db 
margin_db = 2; 
global trialNum_db 
trialNum_db = trialNum + margin_db;
global nback 
nback = 0; 
global rest 
rest = 30;
global margin_stop 
margin_stop = 0; 
global limit
limit = 345; %5*60 + rest + margin_stop; 
global pc_user 
pc_user = 'mitsu_gtec'; 
global modelName 
modelName = 'EyeClosed';