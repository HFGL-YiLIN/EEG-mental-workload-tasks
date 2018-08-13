function varargout = VS64(varargin)
% VS64 MATLAB code for VS64.fig
%      VS64, by itself, creates a new VS64 or raises the existing
%      singleton*.
%
%      H = VS64 returns the handle to a new VS64 or the handle to
%      the existing singleton*.
%
%      VS64('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VS64.M with the given input arguments.
%
%      VS64('Property','Value',...) creates a new VS64 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VS64_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VS64_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VS64

% Last Modified by GUIDE v2.5 14-Apr-2016 15:03:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VS64_OpeningFcn, ...
                   'gui_OutputFcn',  @VS64_OutputFcn, ...
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


% --- Executes just before VS64 is made visible.
function VS64_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VS64 (see VARARGIN)

% Choose default command line output for VS64
handles.output = hObject;

% %% set up       
% global cardColor
% cardColor={'?', 'c'};
% global userAnsdb
% userAnsdb = cell(0);
% global trialNo
% trialNo = 1;
% global accuracy
% accuracy = zeros(1, 333);
% global point1
% point1 = zeros(1, 333);
% global correctAnsdb
% correctAnsdb = cell(0);

%%
global cardNum
cardNum = 64; % not button # 

global_para_VS;

% set up db 
cardDb = cell(1,numel(cardColor)*numel(card_color_1)*2); % 'b', '|', left & right, 64
cardIdx = 0;
for colorIdx = 1:numel(cardColor)
    for idx0 = 1:numel(card_color_1)
        cardIdx = cardIdx+1;
        cardDb{cardIdx} = horzcat(cardColor{colorIdx},card_color_1{idx0});
        cardDb{cardIdx+32} = horzcat(card_color_1{idx0}, cardColor{colorIdx});
    end
end

correctAnsdb = cell(trialNum_db, cardNum); % matrix(trialNum+nback X cardNum)
monitorAnsdb = cell(1, trialNum_db);
for i = 1:trialNum_db
    idx1 = randperm(cardNum);
    for j=1:cardNum
        correctAnsdb{i,j} = cardDb{idx1(j)};
    end

    idx2 = randperm(numel(correctAnsdb(i,:)));
    monitorAnsdb{i} = correctAnsdb{i,idx2(1)};
end
%%
% %% instruction
% text1 = ['\n\n\nIn this task, you will be asked to pair the information among distracitons.\n\n', ...
%          'First, you will see a prompt of a target in the monitor zone, which will disappear in 0.8 second.\n\n', ...
%          'Try to remember the target, and then search for it through the operation zone full of distractions.\n\n', ...
%          'Once you think you find out the right one, please click the target label as well as "start" button to continue\n\n', ...
%          'Notice, you will have only one chance to make the decision, and there is also a time limitation.'];
% blurb1 = sprintf(text1);        
%          set (handles.instructionText, 'FontSize', 14, ...
%               'string', blurb1);

%% unable buttons 
for i = 1:cardNum   
    cardNumidx = ['pushbutton' num2str(i)];
    tmp1 = get(handles.(cardNumidx), 'enable');
   if  strcmp(tmp1,'on')
       set(handles.(cardNumidx), 'enable', 'off');
   end
end

% Update handles structure
guidata(hObject, handles);
  
 
% UIWAIT makes VS64 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VS64_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbuttoni.
function pushbuttoni_Callback(hObject,callbackdata, handles, buttonNum)
% buttonNum    handle to pushbuttoni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%
global monitorAnsdb
global infoOncard
global cardNum
global trial_nth
global nback
global trial_idx 
global outfile
global correctAnsdb
global totaltrials_co
global totaltrials_inco
global rt
global rt_co 
global trialNum
global limit 

global totalacc
global totaltrials
global accuracy
global modelName
global totalrt

% global userAnsdb
% global numItr
%userAnsdb{numel(userAnsdb)+1}=horzcat(num2str(numItr+1),infoOncard);
%userAnsdb{end+1}=horzcat(num2str(numItr+1),infoOncard);
% userAnsdb{end+1}=infoOncard;

%% timestamp
% global c1
% global timeUserdb
% c1=clock;
% timeUserdb{end+1}=mat2str(c1);
% global pointff
global point_RT
global point_RT_0
global tic_timeSD1
global tic_RT

% global timeD
% timeD{end+1}=num2str(point1);
% save('timeD.mat', 'timeD');

timeSD_check_stop = toc(tic_timeSD1);

callbackFunc = @pushbuttoni_Callback;
infoOncard = get(handles.(buttonNum),'string');

set(handles.feedback, 'foregroundcolor', 'black');

%% ++++++++++++++++++++++++++ task 
if timeSD_check_stop >= limit || trial_nth >= trialNum + 1


set(handles.feedback, 'visible', 'off');
%% reset 
% stop(handles.t);
set(handles.feedback, 'visible', 'off');

set_param(modelName,'SimulationCommand','Stop');

tmp0 = get(handles.operationzone, 'visible');
if strcmp(tmp0,'on')
   set(handles.operationzone, 'visible','off');
end

%%
set (handles.monitor,'FontSize', 25, 'String', ...
     horzcat('Congradulations!',10,'Test is complete!'));
set (handles.pushbutton_controlTest, 'enable', 'on');
pause(1);

% check ACCURACY of MATH ANSWERS
totalacc = totalacc + sum(accuracy);
totaltrials = totaltrials + (trial_nth-nback-1); % totaltrials = blocksize
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
    
else % +++++++++++++++++++++++++++++++++++++++
%% first RT 
if trial_nth < trial_idx
   point_RT_0 = toc(tic_timeSD1);
   point_RT_0;
   % 'SUBJNO,trial_nth,PROBE,TIMRSD,RT,RECALLED,ACCURACY'
fprintf(outfile, ',%2.4f,%s', point_RT_0, infoOncard);
else
    point_RT = toc(tic_RT);
    point_RT
    fprintf(outfile, ',%2.4f,%s', point_RT, infoOncard);
end 
%% button crl

%shows button is depressed
if isequal(infoOncard,monitorAnsdb{trial_nth}) % correct 
   set(handles.feedback, 'foregroundcolor', 'green');
%    for i = 1:cardNum   
%        cardNumidx = ['pushbutton' num2str(i)];
%        set(handles.(cardNumidx), 'string', '');
%        set(handles.(cardNumidx), 'enable', 'off');
%    end

   accuracy(trial_nth) = 1;
   fprintf(outfile, ',%d\n', accuracy(trial_nth));
   totaltrials_co(trial_nth-nback) = 1;
   point_RT_0;
   if trial_nth < trial_idx
      rt(trial_nth-nback) = point_RT_0;
      rt_co(trial_nth-nback) = point_RT_0;
   else
       rt(trial_nth-nback) = point_RT;
       rt_co(trial_nth-nback) = point_RT;
   end
   trial_nth = trial_nth + 1; 
%    trial_idx = trial_idx + 1; 
%% pass value 
% to monitor 
set(handles.monitor, 'string', ...
    monitorAnsdb{trial_nth});

probe = monitorAnsdb{trial_nth}; 
 
fprintf(outfile, ',%d,%s', trial_nth, probe);


% to buttons         
idx = 0;
for i = 1:cardNum   
    cardNumidx = ['pushbutton' num2str(i)];
    tmp1 = get(handles.(cardNumidx), 'enable');
   if  strcmp(tmp1,'on')
       idx = idx+1;
       set(handles.(cardNumidx), 'string', correctAnsdb{trial_nth,idx});
       set(handles.(cardNumidx), 'callback', ...
           {callbackFunc,handles,cardNumidx});
   else 
       idx = idx+1;
       set(handles.(cardNumidx), 'enable', 'on');
       set(handles.(cardNumidx), 'string', correctAnsdb{trial_nth,idx});
       set(handles.(cardNumidx), 'callback', ...
           {callbackFunc,handles,cardNumidx});
   end
end

timeSD1 = toc(tic_timeSD1);
% 'SUBJNO,trial_nth,PROBE,TIMRSD,RT,RECALLED,ACCURACY'
fprintf(outfile, ',%2.4f', timeSD1);

tic_RT = tic;

else
%     for i = 1:cardNum   
%         cardNumidx = ['pushbutton' num2str(i)];
%         set(handles.(cardNumidx), 'string', '');
%         set(handles.(cardNumidx), 'enable', 'off');
%     end
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
       set(handles.feedback, 'foregroundcolor', 'red');
       
       accuracy(trial_nth) = 0;
       fprintf(outfile, ',%d\n', accuracy(trial_nth));
       totaltrials_inco(trial_nth-nback) = 1;
       if trial_nth < trial_idx
          rt(trial_nth-nback) = point_RT_0;
       else
           rt(trial_nth-nback) = point_RT;  
       end
       trial_nth = trial_nth + 1; 
%        trial_idx = trial_idx + 1; 
       
       %% pass value 
% to monitor 
set(handles.monitor, 'string', ...
    monitorAnsdb{trial_nth});

probe = monitorAnsdb{trial_nth}; 
 
fprintf(outfile, ',%d,%s', trial_nth, probe);


% to buttons         
idx = 0;
for i = 1:cardNum   
    cardNumidx = ['pushbutton' num2str(i)];
    tmp1 = get(handles.(cardNumidx), 'enable');
   if  strcmp(tmp1,'on')
       idx = idx+1;
       set(handles.(cardNumidx), 'string', correctAnsdb{trial_nth,idx});
       set(handles.(cardNumidx), 'callback', ...
           {callbackFunc,handles,cardNumidx});
   else 
       idx = idx+1;
       set(handles.(cardNumidx), 'enable', 'on');
       set(handles.(cardNumidx), 'string', correctAnsdb{trial_nth,idx});
       set(handles.(cardNumidx), 'callback', ...
           {callbackFunc,handles,cardNumidx});
   end
end

timeSD1 = toc(tic_timeSD1);
fprintf(outfile, ',%2.4f', timeSD1);
tic_RT = tic;

end 
end


% --- Executes on button press in startpb.
function pushbutton_controlTest_Callback(hObject, eventdata, handles)
% hObject    handle to startpb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% set up 
global outfile
global rest
global modelName 
global correctAnsdb
global trial_nth
global trial_idx
global monitorAnsdb
global cardNum

% time ctrl 
global tic_timeSD1 % start gap
global tic_RT_0
callbackFunc = @pushbuttoni_Callback;
%% reset 
% subjno = get (handles.subjnumber, 'String');
set(handles.participantno, 'visible', 'off');
set(handles.subjnumber, 'visible', 'off');
set(handles.nocheck, 'visible', 'off');
set(hObject, 'visible', 'off');

%% gtec control
% modelName = 'controlTest';
 
% opens the Simulink model
% open_system(modelName);

tmp = get(hObject,'String');
%status = get_param(bdroot,'simulationstatus');
% global c3

if strcmp(tmp,'RUN g.tec')   
    %% pass value 
% to monitor 
set(handles.monitor, 'string', ...
    monitorAnsdb{trial_nth});

probe = monitorAnsdb{trial_nth}; 
 
% to buttons         
idx = 0;
for i = 1:cardNum   
    cardNumidx = ['pushbutton' num2str(i)];
    tmp1 = get(handles.(cardNumidx), 'enable');
   if  strcmp(tmp1,'on')
       idx = idx+1;
       set(handles.(cardNumidx), 'string', correctAnsdb{trial_nth,idx});
       set(handles.(cardNumidx), 'callback', ...
           {callbackFunc,handles,cardNumidx});
   else 
       idx = idx+1;
       set(handles.(cardNumidx), 'enable', 'on');
       set(handles.(cardNumidx), 'string', correctAnsdb{trial_nth,idx});
       set(handles.(cardNumidx), 'callback', ...
           {callbackFunc,handles,cardNumidx});
   end
end
trial_idx = trial_idx + 1; 
fprintf(outfile, ',%d,%s,%s', trial_nth, probe, 'no_st');


   tic_timeSD1 = tic; % start gap
%    c3=clock;
%    global timeExpstart
%    timeExpstart{end+1}=mat2str(c3);
%    save('timeExpstart','timeExpstart');
% pause(rest);
   set_param(modelName,'SimulationCommand','Start');
   set(hObject,'string','END EXPERIMENT');
   set(hObject, 'enable', 'off');

else
%       global timeExp
%       point2=toc;
%       timeExp{end+1}=num2str(point2);
%       save('timeExp','timeExp');
    set_param(modelName,'SimulationCommand','Stop');
    set(hObject,'string','RUN g.tec');
%     fclose(outfile);
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
outfile = fopen([datafolder 'VS64_' num2str(subjno) '.csv'], 'w');
fprintf(outfile,'SUBJNO,TRIAL_nth,PROBE,TIMRSD,RT,RECALLED,ACCURACY\n'); %RT = timeSD     
fprintf(outfile, '%s', num2str(subjno));


