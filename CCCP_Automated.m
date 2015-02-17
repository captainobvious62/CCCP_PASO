% Combined Cross Correlation Program Main Script
%
% This is a stand in for the eventual GUI that is being crafted for control
% of this program. It serves as a means of providing standardization of
% the process.
%
% Make the following are set before running!
%--------------------------------------------
% - All parameters in the 'general_settings.m' file are correct
% - Template file created according to format and placed in the
% 'template_folder' directory
% - A reliable internet connection is available



addpath(genpath('/home/geovault-00/rlwalker/MATLAB/seizmo'))
addpath(genpath('/home/geovault-00/rlwalker/MATLAB/GISMO'))
addpath(genpath('/home/geovault-00/rlwalker/MATLAB/CCCP_PASO'))
%Script to break amount down into more manageable time segments
num_iterations = 1;

% Set name for template file (this will be provided by a search dialog in a
% the GUI incarnation

%template_file = ['PASO'];
%templates = str2func(template_file);
%[template_list,template_names] = templates();
pickImport; %If using HypoDD Style Picks
general_settings
initial = datenum(sprintf('%02d/%02d/%04d',start_month,...
    start_day,start_year));
terminal = datenum(sprintf('%02d/%02d/%04d',end_month,end_day,end_year));



duration = terminal - initial;
increment = duration/num_iterations;

generateTemplates;
step = 1;

for step = 1:num_iterations
    
    
    first_date = initial + (step - 1)*increment;
    last_date = initial + step*increment;
    CCCP_Download_Buffer
    CCCP_Zero
    CCCP_I
    CCCP_II
    CCCP_III
    CCCP_IV
    CCCP_V
    CCCP_VI
end
