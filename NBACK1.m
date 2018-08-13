function varargout = NBACK1(varargin)
% NBACK1 MATLAB code for NBACK1.fig
%      NBACK1, by itself, creates a new NBACK1 or raises the existing
%      singleton*.
%
%      H = NBACK1 returns the handle to a new NBACK1 or the handle to
%      the existing singleton*.
%
%      NBACK1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NBACK1.M with the given input arguments.
%
%      NBACK1('Property','Value',...) creates a new NBACK1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NBACK1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NBACK1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NBACK1

% Last Modified by GUIDE v2.5 14-Apr-2016 15:03:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NBACK1_OpeningFcn, ...
                   'gui_OutputFcn',  @NBACK1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before NBACK1 is made visible.
function NBACK1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NBACK1 (see VARARGIN)

% Choose default command line output for NBACK1
handles.output = hObject;

%% set up      
global nback 
nback = 1; 

global_para_NB;

%% timer 
start_delay = 0; % see data of traning block
handles.t = timer('StartDelay',start_delay, ...
                  'StartFcn', ...
                  {@myTimer_startFcn_callback, hObject}, ...
                  'TimerFcn', ...
                  {@myTimer_callback, hObject}, ... 
                  'StopFcn', ... 
                  {@myTimer_stopFcn_callback, hObject}, ...    
                  'Period', 0.001, ... 
                  'TasksToExecute', trialNum, ...
                  'ExecutionMode', 'fixedSpacing');
              
%% unable buttons 
tmp1 = get(handles.pushbutton1, 'enable');
if  strcmp(tmp1,'on')
    set(handles.pushbutton1, 'enable', 'off');
end

%% Update handles structure
guidata(hObject, handles);


function myTimer_startFcn_callback(obj, event, hFigure)
    
handles = guidata(hFigure);  %handles = guidata(figHandle);% get the latest copy of handles

%% set up db 

global cardNum
global cardColor
global nback
global correctAnsdb
global monitorAnsdb
global t1 
global t2 
global t3
global outfile 
global trial_nth
global trial_idx
global trialNum
global trialNum_dbplus 
% time ctrl 
global tic_timeSD1 % start gap 
global point2 % start gap 


% tmp0 = get(handles.uibuttongroup1,'visible'); % show the buttons at the beginning 
% if strcmp(tmp0,'on')
%    set(handles.uibuttongroup1,'visible','off');
% end
%% set up db
global extra_num_1
extra_num_1 = 3; 
global extra_num_2
extra_num_2 = 2; 
global extra_num_3
extra_num_3 = 2;    
global extra_num_4
extra_num_4 = 2; 
global extra_num_5
extra_num_5 = 2; % modify as tasks 

extra_1 = cell(1, extra_num_1);
extra_2 = cell(1, extra_num_2); 
extra_3 = cell(1, extra_num_3);
extra_4 = cell(1, extra_num_4);
extra_5 = cell(1, extra_num_5);
correctAnsdb = cell(trialNum_dbplus, cardNum);
correctAnsdb_ran = correctAnsdb;
for i = 1:trialNum_dbplus
    idx1 = randperm(numel(cardColor));
    for j=1:extra_num_1
        extra_1{j} = cardColor{idx1(j)};
    end
    
    idx2 = randperm(numel(extra_1));
    for k=1:extra_num_2
        extra_2{k} = extra_1{idx2(k)};
    end
    
    idx3 = randperm(numel(extra_1));
    for l=1:extra_num_3
        extra_3{l} = extra_1{idx3(l)};
    end
    
    idx4 = randperm(numel(extra_1));
    for m=1:extra_num_4
        extra_4{m} = extra_1{idx4(m)};
    end
    
    idx5 = randperm(numel(extra_1));
    for n=1:extra_num_5
        extra_5{n} = extra_1{idx5(n)};
    end
    
    correctAnsdb(i,:) = [extra_2,extra_3,extra_4,extra_5];
    
    idx6 = randperm(numel(correctAnsdb(1,:)));
    for o=1:cardNum
        correctAnsdb_ran{i,o} = correctAnsdb{i,idx6(o)};
    end
end

%%
monitorAnsdb = cell(1, cardNum*trialNum_dbplus);
for i = 1:cardNum
    for j = 1:trialNum_dbplus
        monitorAnsdb{i+7*(j-1)} = correctAnsdb_ran{j,i};
    end
end

%% 1st trial 
point2 = toc(tic_timeSD1); % start gap 

set(handles.monitor, 'string', monitorAnsdb{1}); 
pause(t1);
set (handles.monitor, 'string', '');
pause(t2);
pause(t3);
pause(0.02);

%%
global probe_first
probe_first = monitorAnsdb{1};
 
fprintf(outfile, ',%d,%s,%2.4f', 1, probe_first, point2);

% trial_nth = trial_nth + 1;
% trial_idx = trial_idx + 1; 

% %% 2nd trial 
% point2 = toc(tic_timeSD1); 
% 
% set(handles.monitor, 'string', monitorAnsdb{nback}); 
% pause(t1);
% set (handles.monitor, 'string', '');
% pause(t2);
% 
% %%
% probe_first = monitorAnsdb{nback};
%  
% fprintf(outfile, ',%d,%s,%2.4f', nback, probe_first, point2);

trial_nth = trial_nth + nback;
trial_idx = trial_idx + nback; 

          
function myTimer_callback(obj, event, hFigure)
     
handles = guidata(hFigure); %handles = guidata(figHandle);% get the latest copy of handles

%% set up db 
global t1
global t2
global t3
global correctAnsdb
global monitorAnsdb
global cardNum
global nback
global cardColor
% global trialNum_idx % set in open, +1 in the end of timefuncall, for switch rows of correctAnsdb & monitorAnsdb 
global trial_nth
global acc_nth
global trial_idx 
global accuracy
global outfile
global probe 

% time ctrl 
global tic_timeSD1
global point2   % start gap 
global tic_RT

%% reset 
% callbackFunc = @pushbuttoni_Callback;

set(handles.feedback, 'foregroundcolor', 'black');

% tmp0 = get(handles.uibuttongroup1, 'visible');
% if strcmp(tmp0,'off')
%    set(handles.uibuttongroup1, 'visible','on');
% end

%% start gap
point2 = toc(tic_timeSD1);

%% pass values 
% pass to monitor
set(handles.monitor, 'string', ...
    monitorAnsdb{trial_nth});
probe = monitorAnsdb{trial_nth}; 
  
% pass to buttons, 
% .9ms
tmp1 = get(handles.pushbutton1, 'enable');
if  strcmp(tmp1,'on')
    set(handles.pushbutton1, 'string', monitorAnsdb{trial_nth});
   else 
       set(handles.pushbutton1, 'enable', 'on');
       set(handles.pushbutton1, 'string', monitorAnsdb{trial_nth});
end

%   global infoOnmonitor
%   infoOnmonitor = get(handles.monitor, 'string');

tic_RT = tic;

pause(t1); 
set(handles.monitor, 'string', ''); 
pause(t2); 

%% no button push, 
% .9ms
if trial_idx <= trial_nth 
   
   tmp0 = get(handles.pushbutton1, 'string');
   if isequal(tmp0,monitorAnsdb{trial_nth-nback})
      set(handles.feedback, 'foregroundcolor', 'blue');
      tmp1 = get(handles.pushbutton1, 'enable');
      if  strcmp(tmp1,'on')
          set(handles.pushbutton1, 'string', '');
          set(handles.pushbutton1, 'enable', 'off');
      end
      
      accuracy(acc_nth) = 0;
      infoOncard = 'nichts';
      timeout = t2;

      fprintf(outfile, ',%d,%s,%d\n', timeout, infoOncard, accuracy(acc_nth));
      fprintf(outfile, ',%d,%s,%2.4f', trial_nth, probe, point2);
      trial_nth = trial_nth + 1;
      acc_nth = acc_nth + 1; 
      trial_idx = trial_idx + 1; 
      pause(t3);
   else
       tmp1 = get(handles.pushbutton1, 'enable');
       if strcmp(tmp1,'on')
          set(handles.pushbutton1, 'string', '');
          set(handles.pushbutton1, 'enable', 'off');
       end
       
%        accuracy(trial_nth-nback) = 1;
       infoOncard = ['mind' monitorAnsdb{trial_nth-nback}];
       timeout = t2;

%        fprintf(outfile, ',%d,%s,%d\n', timeout, infoOncard, accuracy(acc_nth));
       fprintf(outfile, ',%d,%s\n', timeout, infoOncard);
       fprintf(outfile, ',%d,%s,%2.4f', trial_nth, probe, point2);
       trial_nth = trial_nth + 1;
       trial_idx = trial_idx + 1;        
       pause(t3);
   end      
else 
    fprintf(outfile, ',%d,%s,%2.4f', trial_nth, probe, point2);
    trial_nth = trial_nth + 1;
%       trial_idx = trial_idx + 1; 
    pause(t3);
end
    
    
function myTimer_stopFcn_callback(obj, event, hFigure)
     
handles = guidata(hFigure); %handles = guidata(figHandle);% get the latest copy of handles

%% global variables 
global nback
global totalacc;
global totaltrials
% global trialNum_idx % set in open, +1 in the end of timefuncall, for switch rows of correctAnsdb & monitorAnsdb 
global trial_nth
global acc_nth
global accuracy
global modelName
global outfile 
global totaltrials_co
global totaltrials_inco
global totalrt
global rt
global rt_co

%% reset 
stop(handles.t);
set(handles.feedback, 'visible', 'off');

set_param(modelName,'SimulationCommand','Stop');

% tmp0 = get(handles.uibuttongroup1, 'visible');
% if strcmp(tmp0,'on')
%    set(handles.uibuttongroup1, 'visible','off');
% end

%%
set (handles.monitor,'FontSize', 25, 'String', ...
     horzcat('Congradulations!',10,'Test is complete!'));
set (handles.pushbutton_controlTest, 'enable', 'on');
pause(1);
% calculation
totalacc = totalacc + sum(accuracy);
totaltrials = totaltrials + (acc_nth-1); % totaltrials = blocksize
pct = round((totalacc/totaltrials) * 100);

totaltrials_rtall_idx = 0;
totaltrials_rtco_idx = 0;
totalrt_co = 0;
totalrt_co = totalrt_co + sum(rt_co);
totalrt = totalrt + sum(rt);
totaltrials_rtall_idx =  totaltrials_rtall_idx + sum(totaltrials_co) + sum(totaltrials_inco);
if sum(totaltrials_rtall_idx) ~= 0
   rt_all_mean = totalrt/totaltrials_rtall_idx;
else
    rt_all_mean = 'nichts'; 
end

totaltrials_rtco_idx =  totaltrials_rtco_idx + sum(totaltrials_co);
if sum(totaltrials_co) ~= 0
   rt_co_mean = totalrt_co/totaltrials_rtco_idx;
else 
    rt_co_mean = 'nichts';
end

if pct < 90
   % not doing so well
   text1 = ['So far, your TOTAL accuracy is:\n', ...
                 '             %d%%\n', ...
                 'Please try to focus on pairing more carefully.'];
   blurb1 = sprintf(text1, pct);       
   set (handles.monitor, 'FontSize', 16, 'ForegroundColor', 'red', ...
             'string', blurb1);
  else
      % doing fine
      text2 = ['So far, your TOTAL accuracy is:\n', ...
                 '             %d%%\n', ...
                 'Good Job!'];
      blurb2 = sprintf(text2, pct);
      set (handles.monitor, 'FontSize', 16, 'ForegroundColor', 'green', ...
           'string', blurb2);
end  

%% 
if sum(totaltrials_rtall_idx) ~= 0
   fprintf(outfile, '\n%s,%s,%s\n%d,%d', 'RA', 'RT_ALL_MEAN', 'RT_CO_MEAN', pct, rt_all_mean);
else
    fprintf(outfile, '\n%s,%s,%s\n%d,%s', 'RA', 'RT_ALL_MEAN', 'RT_CO_MEAN', pct, rt_all_mean);
end

if sum(totaltrials_co) ~= 0
   fprintf(outfile, ',%d', rt_co_mean);
else
    fprintf(outfile, ',%s', rt_co_mean);
end

fclose(outfile);
    
    
% --- Executes on button press in pushbuttoni.
function pushbutton1_Callback(hObject, eventdata, handles)
% buttonNum    handle to pushbuttoni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%
global monitorAnsdb
global infoOncard
global trial_nth
global acc_nth
global trial_idx 
global nback
global outfile
global totaltrials_co
global totaltrials_inco
global rt
global rt_co
global t2 

% global userAnsdb
% global numItr
%userAnsdb{numel(userAnsdb)+1}=horzcat(num2str(numItr+1),infoOncard);
%userAnsdb{end+1}=horzcat(num2str(numItr+1),infoOncard);
% userAnsdb{end+1}=infoOncard;

%% time ctrl 
% c1=clock;
% timeUserdb{end+1}=mat2str(c1);
% global pointff
global point_RT
global tic_RT
global accuracy
% global timeD
% timeD{end+1}=num2str(point1);
% save('timeD.mat', 'timeD');
point_RT = toc(tic_RT);
point_RT

%% button crl
infoOncard = get(hObject,'string');

if point_RT < t2
%shows button is depressed
if isequal(infoOncard,monitorAnsdb{trial_nth-nback})
   set(handles.feedback, 'foregroundcolor', 'green');
   set(handles.pushbutton1, 'string', '');
   set(handles.pushbutton1, 'enable', 'off');
%    set(handles.uibuttongroup1,'visible','off');
%    set(handles.(buttonNum),'enable','off');  
%    set(handles.startpb,'enable','on');  
%    set(handles.monitor,'foregroundcolor','green', ...
%        'string','Correct');
%    set(handles.(buttonNum),'visible','off');
     
%    numItr=numItr+1;

   accuracy(acc_nth) = 1;
   totaltrials_co(trial_nth-nback) = 1;
   rt(trial_nth-nback) = point_RT;
   rt_co(trial_nth-nback) = point_RT;
   trial_idx = trial_idx + 1; 
   acc_nth = acc_nth + 1; 
else
    set(handles.feedback, 'foregroundcolor', 'red');
    set(handles.pushbutton1, 'string', '');
    totaltrials_inco(trial_nth-nback) = 1;
    rt(trial_nth-nback) = point_RT;
    set(handles.pushbutton1, 'enable', 'off');
%     set (handles.uibuttongroup1,'visible','off');
%        set(handles.startpb,'enable','on');
%        set(handles.monitor,'foregroundcolor','red', ...
%          'string','Incorrect');%warning of a wrong click
%       for i=1:cardNum   
%        cardNumidx = ['pushbutton' num2str(i)];
%        tmp=get(handles.(cardNumidx), 'string');
%          if  strcmp(tmp,infoOnmonitor);
%              set(handles.(cardNumidx),'enable','off');
%              set(handles.(cardNumidx),'visible','off');
%          end
%       end
 
%      numItr=numItr+1;
    accuracy(acc_nth) = 0;
    totaltrials_inco(trial_nth-nback) = 1;
    rt(trial_nth-nback) = point_RT;
    trial_idx = trial_idx + 1; 
    acc_nth = acc_nth + 1; 
end

% 'SUBJNO,trial_nth,PROBE,TIMRSD,...,RT,RECALLED,ACCURACY'

fprintf(outfile, ',%2.4f,%s,%d\n', point_RT, infoOncard, accuracy(acc_nth-1)); % cuz acc_nth = acc_nth + 1;, so need to -1
end

% UIWAIT makes NBACK1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NBACK1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function subjnumber_Callback(hObject, eventdata, handles)
% hObject    handle to subjno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subjno as text
%        str2double(get(hObject,'String')) returns contents of subjno as a double


% --- Executes during object creation, after setting all properties.
function subjnumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subjno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startpb.
function pushbutton_controlTest_Callback(hObject, eventdata, handles)
% hObject    handle to startpb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% set up db 
% global outfile
global rest
global modelName 

% time ctrl 
global tic_timeSD1 % start gap
%% reset 
% subjno = get (handles.subjnumber, 'String');
set(handles.participantno, 'visible', 'off');
set(handles.subjnumber, 'visible', 'off');
set(handles.nocheck, 'visible', 'off');
set(hObject, 'visible', 'off');

%% gtec ctrl 

% modelName = 'controlTest';
 
% opens the Simulink model
% open_system(modelName);

tmp = get(hObject,'String');
%status = get_param(bdroot,'simulationstatus');
% global c3

if strcmp(tmp,'RUN g.tec')
   tic_timeSD1 = tic; % start gap
%    c3=clock;
%    global timeExpstart
%    timeExpstart{end+1}=mat2str(c3);
%    save('timeExpstart','timeExpstart');
   set_param(modelName,'SimulationCommand','Start');
   set(hObject,'string','END EXPERIMENT');
   set(hObject, 'enable', 'off');
   
   pause(rest);
   
   stop(handles.t);
   start(handles.t); % run timer function 
else
    set_param(modelName,'SimulationCommand','Stop');
    set(hObject,'string','RUN g.tec');
end

% --- Executes on button press in startpb.
function nocheck_Callback(hObject, eventdata, handles)
% hObject    handle to startpb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% set up folder 
global pc_user 
% datafolder = 'C:\Users\LIN\Documents\MATLAB\PTBpj2.0\nocancel1.1\ex264MentalWorkload\PMW64\data';
% datafolder = 'C:\Users\cdhaw\Documents\MATLAB\PTBpj2.0\nocancel1.1\ex264MentalWorkload\PMW64\data';
% datafolder = 'C:\Users\mitsu_gtec\Documents\MATLAB\PTBpj2.0\nocancel1.1\ex264MentalWorkload\PMW64\data';

datafolder = fullfile('C:','Users',pc_user,'Documents', ...
                      'MATLAB','PTBpj2.0','nocancel1.1', ...
                      'ex264MentalWorkload','PMW64','data', filesep);

% open up output file
datafolder = makeValidPath(datafolder);
% Move to correct folder:
cd(datafolder);

global subjno
subjno = get(handles.subjnumber, 'String');
global outfile
outfile = fopen([datafolder 'NBACK1_' num2str(subjno) '.csv'], 'w');
fprintf(outfile,'SUBJNO,trial_nth,PROBE,TIMRSD,RT,RECALLED,ACCURACY\n'); %RT = timeSD     
fprintf(outfile, '%s', num2str(subjno));

