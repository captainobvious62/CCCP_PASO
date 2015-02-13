
% CCCP Step II 
%
%
% Grab Correlations - Step II

%general_settings
%[template_list,template_names] = templates();
%pickImport
disp('Running CCCP II')
for template_count = 1:length(template_list);
    template = template_names{template_count};
    folder_check = sprintf('./Results/%s',template_names{template_count});
    if exist(folder_check,'dir')~=7
        mkdir(folder_check);
    end
    result_savename = sprintf('Results/Combined_Results_%s_to_%s.mat',...
        datestr(first_date),datestr(last_date));
    results = load(result_savename);
    iterResult = results.results{template_count};
	parfor station_count = 1:length(template_list{template_count})
        %[template_list,tn] = templates();
        station_list = template_list{template_count};
        template = template_names{template_count};
        station_list = addNumericTime(station_list);
        moveout = station_list(station_count).sWaveArrivalNumeric...
            - station_list(1).sWaveArrivalNumeric;
        NET = station_list(station_count).network;
        STA = station_list(station_count).station;
        LOC = station_list(station_count).location;
        trigger = station_list(station_count).trigger;
        template_channels = station_list(station_count).channel_list;
        CHAN_LIST = station_list(station_count).channel_list;
        for chan_count = 1:length(CHAN_LIST);
            CHA = CHAN_LIST{chan_count};
            CHA_TEMPLATE = template_channels{chan_count};
            fprintf('Producing Correlations for %s %s %s %s,%s to %s\n',...
                template,NET,STA,CHA,datestr(first_date),...
                datestr(last_date));
            directory_check = sprintf('./%s/%s/%s/%s/CO',...
                NET,STA,CHA,template);
            if exist(directory_check,'dir') ~= 7;
                mkdir(directory_check);
                fprintf('Template directory created \n');
            end
            if isempty(iterResult) ~=1
                [correlation_object,correlation_object_savename] = ...
                    generateCorrelations(STA,NET,LOC,CHA,CHA_TEMPLATE,...
                    moveout,iterResult,lower_band,upper_band,...
                    before_S_Wave,...
                    after_S_Wave,template,datestr(first_date),...
                    datestr(last_date),trigger)
                parsave(correlation_object_savename,correlation_object);
            end
        end
    end
end
