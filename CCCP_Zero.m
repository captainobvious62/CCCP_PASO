% CCCP Step Zero - Cross Correlations
%
% Having cached the timeseries data in the previous script, this step
% performs and saves cross correlations for all stations for the whole
% interval. These are then stacked by channel and by station.
%
%
%Populate Station Data - Step 0
%warning('off','all')
%general_settings
%[template_list,template_names] = templates();
% NOTE: This needs the Seizmo toolkit

disp('Running CCCP Zero')
% for template_count = 1:length(template_list)
%     station_list = template_list{template_count};
%     clearresults(station_list(1),first_date,last_date)
% end
for i = first_date:last_date    
    YEAR = datevec(i);
    YEAR = YEAR(1);
    DDD = date2doy(i);
    fprintf('Iteration for %s %s commenced %s\n',num2str(YEAR),...
        num2str(DDD),datestr(now));
    dayResults = [];
    parfor template_count = 1: length(template_list);
        station_list = template_list{template_count};
        for station_count = 1:length(station_list)
            station_list(station_count).template_channels =...
                station_list(station_count).channel_list;
            template_channels = station_list(station_count).channel_list;
            single_station = station_list(station_count);
            folder_check = sprintf('./%s/%s/CCC/%s',...
                single_station.network,single_station.station,...
                single_station.template);
            if exist(folder_check,'dir')~=7
                mkdir(folder_check);
            end
            ccc_STA_savename =...
                sprintf('./%s/%s/CCC/%s/cccSum.%04d.%03d.mat',...
                single_station.network,single_station.station,...
                single_station.template,YEAR,DDD);
            if exist(ccc_STA_savename,'file') == 0
               [time,ccc_STA] = CC_station_day(single_station.template,...
                   single_station.network,single_station.station,YEAR,...
                   DDD,single_station.channel_list{1},...
                   single_station.channel_list{2},...
                   single_station.channel_list{3},single_station.freq);
                parsave(ccc_STA_savename,ccc_STA);
            end
            station_list = addNumericTime(station_list);
        end
        [station_list, peak_times_tosave] =...
            sumEvents_allSTA(station_list,YEAR,DDD);
        dayResults = saveresults_inside(i,template_count,...
            peak_times_tosave,station_list(1),first_date,last_date);
        template_result_savename = sprintf('./Results/%s/%s_to_%s.mat',...
            template_names{template_count},datestr(first_date),...
            datestr(last_date));
    end  
end


    
