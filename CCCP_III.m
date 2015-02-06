%CCCP III - Arrival Time Generation
%general_settings
%[template_list,template_names] = templates();
%pickImport
result_savename = sprintf...
    ('./Results/Combined_Results_%s_to_%s.mat',...
    datestr(first_date),datestr(last_date));

parfor template_count = 1:length(template_list)
    station_list = template_list{template_count};
    for station_count = 1:length(station_list)
        template_channels = station_list(station_count).channel_list;
        station_list(station_count).template_channels = template_channels;
        single_station = station_list(station_count);
        NET = station_list(station_count).network;
        STA = station_list(station_count).station;
        folder_check = sprintf('./%s/%s/arrivals/%s',...
            single_station.network,single_station.station,...
            single_station.template);
        if exist(folder_check,'dir')~=7
            mkdir(folder_check);
        end
        folder_check = sprintf('./CO/%s',single_station.template);
        if exist(folder_check,'dir')~=7
            mkdir(folder_check);
        end
        fprintf('Producing P and S arrivals for %s %s %s, %s to %s\n',...
            single_station.template,NET,STA,datestr...
            (first_date),datestr(last_date));
        arrival_times = produceArrivalTimes(NET,...
            single_station.channel_list{1},...
            single_station.channel_list{2},...
            single_station.channel_list{3},...
            STA,first_date,last_date,single_station.pWaveArrival,...
            single_station.sWaveArrival,window,single_station.template);
        arrival_savename = ...
            sprintf('./%s/%s/arrivals/%s/arrival_times.%s.to.%s.mat',...
            single_station.network,single_station.station,...
            single_station.template,datestr(first_date),...
            datestr(last_date));
        parsave(arrival_savename,arrival_times);
        if isempty(arrival_times) == 0;
            fprintf('P Arrivals, %s %s\n',single_station.template,STA);
            datestr(arrival_times(:,1))
            fprintf('S Arrivals, %s %s\n',single_station.template,STA);
            datestr(arrival_times(:,2))
        end
    end
end



