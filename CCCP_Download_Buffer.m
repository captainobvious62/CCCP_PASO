% CCCP Download Buffer (Step Minus One)
%
% The purpose of this file is to ensure that data covering the entire
% interval of interest is downloaded, including a plus/minus one day buffer
% time period. It is derived from the CCCP Zero process.

%Download data exceeding requirements/buffer - Step -1
%warning('off','all')

%[template_list,template_names] = templates();
%generateTemplates;
% first_date = datenum(sprintf('%02d/%02d/%04d',start_month,start_day,start_year));
% last_date = datenum(sprintf('%02d/%02d/%04d',end_month,end_day,end_year));
disp('Running CCCP Download Buffer')
parfor i = (first_date):(last_date)
    
    YEAR = datevec(i);
    YEAR = YEAR(1)
    DDD = date2doy(i)
    fprintf('Iteration for %s %s commenced %s\n',num2str(YEAR),num2str(DDD),datestr(now));
    dayResults = [];
    for template_count = 1: length(template_list);
        station_list = template_list{template_count};
        for station_count = 1:length(station_list)
            station_list(station_count).template_channels = station_list(station_count).channel_list;
            template_channels = station_list(station_count).channel_list;
            single_station = station_list(station_count);
 	             % IRISdownload_webServices(single_station.network,single_station.station,single_station.location,YEAR,DDD,single_station.channel_list{1},single_station.channel_list{2},single_station.channel_list{3});
           NCEDCdownload_webServices(single_station.network,single_station.station,single_station.location,YEAR,DDD,single_station.channel_list{1},single_station.channel_list{2},single_station.channel_list{3});
            folder_check = sprintf('./%s/%s/CCC/%s',single_station.network,single_station.station,single_station.template);
            if exist(folder_check,'dir')~=7
                mkdir(folder_check);
            end
            ccc_STA_savename = sprintf('./%s/%s/CCC/%s/cccSum.%04d.%03d.mat',single_station.network,single_station.station,single_station.template,YEAR,DDD);
            if exist(ccc_STA_savename,'file') == 0
	        [time,ccc_STA] = CC_station_day(single_station.template,single_station.network,single_station.station,YEAR,DDD,single_station.channel_list{1},single_station.channel_list{2},single_station.channel_list{3},single_station.freq);
                parsave(ccc_STA_savename,ccc_STA);
            end
            station_list = addNumericTime(station_list);
        end
    end  
end

