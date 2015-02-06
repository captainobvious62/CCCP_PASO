function [correlation_object,correlation_object_savename] = generateCorrelations(STA,NET,LOC,CHA,CHA_TEMPLATE,moveout,matches,low_bp,high_bp,before_grab,after_grab,template,erste,ende,trigger)

correlation_object_savename = sprintf('./%s/%s/%s/%s/CO/%s.to.%s.%s.%s.mat',NET,STA,CHA,template,num2str(erste),num2str(ende),STA,CHA);
correlation_object = correlation();
pick_number = 0;
trace_number = 0;
for i = 1:length(matches(:,1))
    
    sync_date = [datestr(doy2date(matches(i,2),matches(i,1))),' ',datestr((matches(i,3)+moveout)/86400,'HH:MM:SS.FFF')];
    start_time = datenum(sync_date)-before_grab/86400;
    end_time = datenum(sync_date)+after_grab/86400;
    %% Obligitory fix for US network name change
    DAY = matches(i,2);
    YEAR = matches(i,1);
    
    if strcmp(NET,'US') == 1
        
        time = doy2date(DAY,YEAR);
        change_time = datenum('2011-05-03 00:00:00');
        if strcmp(CHA,'BHE') == 1
            if time > change_time
                CHA = 'BH1';
            end;
        end
        if strcmp(CHA,'BHN') == 1
            if time > change_time;
                CHA = 'BH2';
            end
        end
        if strcmp(CHA,'BH1') == 1
            if time < change_time;
                CHA = 'BHE';
            end
        end
        if strcmp(CHA,'BH2') == 1
            if time < change_time;
                CHA = 'BHN';
            end
        end
    end
    %% END OF NONSENSE
    
    WF_Snippet = [];
    counts = 0;
    failure = 0;
    while isempty(WF_Snippet) == 1 && failure == 0
        try
            fprintf('Downloading trace\n')
            WF_Snippet = irisFetch.Traces(NET,STA,LOC, CHA, start_time,end_time,'http://service.ncedc.org','verbose');
            WF_Snippet = convertTraces(WF_Snippet);
        catch exception
            fprintf('Trying again....\n');
        end
        if counts > 5;
            failure = 1;
            fprintf('Counts = %d\n Server connection is not working \n',counts)
        end
        counts = counts + 1;
    end
    if isempty(WF_Snippet) == 1
        index_time = matches(i,3) + moveout;
        begin_time = index_time - before_grab;
        
        if sign(begin_time) == -1
            
            WF_Snippet = [];
        else
            
            fprintf('No Data, trying mseed\n');            
            fprintf('%s %s %s %s %s\n',num2str(YEAR),num2str(DAY,'%03d'),NET,STA,CHA);
            seedfile = dir(strcat([char(NET),'/',char(STA),'/mseed/',char(STA),'.',CHA,'.',num2str(YEAR),'.',num2str(DAY,'%03d')]));
            if isempty(seedfile) ~= 1
                if seedfile.bytes ~= 0
                    if strcmp(NET,'US') == 1                        
                        time = doy2date(DAY,YEAR);
                        change_time = datenum('2011-05-03 00:00:00');
                        if strcmp(CHA,'BHE') == 1
                            if time > change_time
                                CHA = 'BH1';
                            end;
                        end
                        if strcmp(CHA,'BHN') == 1
                            if time > change_time;
                                CHA = 'BH2';
                            end
                        end
                        if strcmp(CHA,'BH1') == 1
                            if time < change_time;
                                CHA = 'BHE';
                            end
                        end
                        if strcmp(CHA,'BH2') == 1
                            if time < change_time;
                                CHA = 'BHN';
                            end
                        end
                    end
                    
                    seed = rdmseed(strcat([char(NET),'/',char(STA),'/mseed/',char(STA),'.',CHA,'.',num2str(YEAR),'.',num2str(DAY,'%03d')]));
                    time_vec=datevec(cat(1,seed.t));
                    day=median(time_vec(:,3));
                    good_day=find(time_vec(:,3)==day);
                    time=sum([[zeros(length(time_vec(good_day)),1),zeros(length(time_vec(good_day)),1),...
                        zeros(length(time_vec(good_day)),1),3600*ones(length(time_vec(good_day)),1),...
                        60*ones(length(time_vec(good_day)),1),ones(length(time_vec(good_day)),1)]'.*time_vec(good_day,:)'])';
                    [B,I,J]=unique(time,'first');
                    temp=cat(1,seed.d);
                    data=temp(intersect(good_day,I));
                    clear temp;
                    freq = seed(1).SampleRate;
                    %bp=bandpass(data,low_bp,high_bp,1/freq,3);
                    index_time = matches(i,3)*freq + moveout*freq;
                    begin_time = index_time - before_grab*freq;
                    
                    fin_time = index_time + after_grab*freq;
                    if length(data) < fin_time
                        WF_Snippet = [];
                    else
                        snippet = data(begin_time:fin_time);
                        WF_Snippet = waveform(STA,CHA,seed(1).SampleRate,start_time,snippet);
                    end
                else
                    WF_Snippet = [];
                end
            end
        end
    end
    %Not sure if we just want to add a filter function later
    %and not filter it in situ
    if isempty(WF_Snippet) ~= 1;
        WF_Snippet = fillgaps(WF_Snippet,0);
        high_bp = get(WF_Snippet,'freq')*(0.8/2);
        WF_Snippet = filter_waveform_BP(WF_Snippet,low_bp,high_bp);
        WF_Snippet = addfield(WF_Snippet,'Rel_MAD',matches(i,4));
        WF_Snippet = addfield(WF_Snippet,'Phase',trigger);
        center_pick = doy2date(matches(i,2),matches(i,1))+matches(i,3)/86400 + moveout/86400;
        WF_Snippet = correlation(WF_Snippet,center_pick);
        
        if pick_number == 0;
            correlation_object = WF_Snippet;
        else
            correlation_object = cat(correlation_object,WF_Snippet);
        end
        pick_number = pick_number + 1;
        trace_number = trace_number + 1;
        fprintf('%s %s %s %s Trace %d\n',template, NET,STA,CHA,trace_number);
    end
end

template_savename = sprintf('./%s/%s/%s/%s/%s.%s.%s.mat',NET,STA,CHA_TEMPLATE,template,template,STA,CHA_TEMPLATE);
%template_savename = sprintf('%s/%s/Templates/%s.%s.%s.mat',NET,STA,template,STA,CHA_TEMPLATE);
load(template_savename)
fprintf('Template %s loaded.\n',template_savename);
wf_Temp = filter_waveform_BP(wf_Temp,low_bp,high_bp);
wf_Temp = correlation(wf_Temp);
if isempty(get(correlation_object,'waveforms')) == 1;
    correlation_object = wf_Temp;
else
    correlation_object = cat(correlation_object,wf_Temp);
end
save(correlation_object_savename,'correlation_object');
fprintf('Correlation object %s saved.\n',correlation_object_savename);

end
