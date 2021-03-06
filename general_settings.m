%General Settings File

%Folder Structure
%Check and if necessary create folder structure
base_folder = 'CCCP';
result_folder = 'outputs';
template_folder = 'templates';
crosscorrelation_folder = 'CC';
waveform_folder = 'WF';
all_stack_folder = 'ALLStack';
station_stack_folder = 'StationStack';
template_stack_folder = 'TemplateStack';
check_folder = 'check';
correlation_object_folder = 'CorrelationObject';
%javaaddpath(sprintf('%s/IRIS-WS-2.0.4.jar',base_folder));

%Time Settings
%All times for program are in UTC
month_length = [31,28,31,30,31,30,31,31,30,31,30,31];

%Starting Date/Time
start_year = 2005;
start_month = 05;
start_day = 03;
start_minute = 00;
start_second = 00;

%Ending Date/Time
end_year = 2005;
end_month = 05;
end_day = 03;
end_minute = 00;
end_second = 00;

%IRIS database doesn't seem to care much about the location
location = '*';

%Template Settings

%Snippet Settings
%Snippet window settings (sec)


%Which phase to use
trigger = 'S';
% %For P Wave Arrrival
% time_before = 10;
% time_after = 10;


%Typical for S Wave
time_before = 10;
time_after = 10;

%Filter Settings
%Settings for HRSN
lower_band = 1;
upper_band = 50;
filter = filterobject('B',[1 50], 4);
scan_increment = 10; % seconds
scan_increment = scan_increment/86400;




%Cross Correlation Review Settings
candidates = 20;
CC_increment = 1; %Value in days
Master_CC_Scan_Threshold = 0.5;

%Correlation object settings
%Time before and after S-Wave pick to grab
before_P_Wave = 5;
after_P_Wave = 25;
before_S_Wave = 30;
after_S_Wave = 30;
%No longer needed
%correlation_channel = 'BHZ';


%Picking Arrival Times
window = 10;












