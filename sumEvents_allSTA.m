function [station_list,peak_times_tosave] =  sumEvents_allSTA(station_list,YEAR,DAY)
YR = YEAR;
YEAR = num2str(YEAR);
DDD = DAY;
DAY = num2str(DAY,'%03d');
%freq = 40;
% CHA_E = 'BHE'
% CHA_N = 'BHN'
% CHA_Z = 'BHZ'

station_list = addNumericTime(station_list);

[dist,index] = sort([station_list(:).sWaveArrivalNumeric],'ascend');
station_list = station_list(index);
station_list(:).station;

freq = zeros(1,length(station_list));
for i = 1:length(station_list)
    freq(i) = station_list(i).freq;
end
base_freq = min(freq);
threshold=8;  %times the MAD above 0
toss_value = 0.2999999; %Value to exceed in seconds
% fid = fopen(['template_',id,'_times_new.txt'], 'w');
% fclose(fid);


%data = cell(1,length(station_list));
template_time = cell(1,length(station_list));
station_time = cell(1,length(station_list));
%ccc = cell(1,length(station_list));
%sum = cell(1,length(station_list));
ccc_sum = zeros(1,60*60*24*base_freq+1);
base_time = 0:1/base_freq:86400;

for i = 1:length(station_list)
    STA = station_list(i).station;
    NET = station_list(i).network;
    template = station_list(i).template;
    freq(i) = station_list(i).freq;
    time=0:1/station_list(i).freq:86400;   %seconds in a day
    CHA_E = station_list(i).channel_list{1};
	CHA_N = station_list(i).channel_list{2};
	CHA_Z = station_list(i).channel_list{3};
    
    [NET,'/',STA,'/CCC/',template,'/cccSum.',num2str(YEAR),'.',num2str(DAY,'%03d'),'.mat'];
    if exist([NET,'/',STA,'/CCC/',template,'/cccSum.',num2str(YEAR),'.',num2str(DAY,'%03d'),'.mat'],'file')
        ccc_STA=load([NET,'/',STA,'/CCC/',template,'/cccSum.',num2str(YEAR),'.',num2str(DAY,'%03d'),'.mat']);

        load(sprintf('%s/%s/%s/Templates/%s/data_%s.%s.%s.mat',NET,STA,CHA_E,template,template,STA,CHA_E));
        load(sprintf('%s/%s/%s/Templates/%s/data_%s.%s.%s.mat',NET,STA,CHA_N,template,template,STA,CHA_N));
        load(sprintf('%s/%s/%s/Templates/%s/data_%s.%s.%s.mat',NET,STA,CHA_Z,template,template,STA,CHA_Z));

        %Load in the time of the start of this template
        template_time=template_Z(1,1);
        
        if i == 1
            %Adjust the time. For this first template, I do no adjustment - every other
            %template will be relative to this one.
            station_time=time-0;
        else
            station_time=time-(template_Z(1,1)-template_time);
            
        end
        str = computer;
        
        if str == 'GLNXA64'
            if isfield(ccc_STA,'data') == 1
                ccc = ccc_STA.data;
            elseif isfield(ccc_STA,'ccc_STA') == 1
                ccc = ccc_STA.ccc_STA;
            end
            ccc(isnan(ccc)) = 0;
        else
            ccc=ccc_STA.ccc_STA;
        end
        if(isempty(ccc))
            ccc=zeros(1,60*60*24*station_list(i).freq);
        end
        
        % sum the cross correlations up, using the adjusted times before
        %interpolating
        arman = interp1(station_time(1:length(ccc)),ccc,time,'linear');
        arman(isnan(arman)) = 0;
        
    end
    %downsample to lowest frequency, if necessary
    if station_list(i).freq > base_freq
        arman = resample(arman,base_freq,station_list(i).freq);
        arman = interp1(station_time(1:length(arman)),arman,base_time,'linear');
        arman(isnan(arman)) = 0;
    end
    ccc_sum = arman + ccc_sum;
    
end

peak_threshold=threshold*mad(ccc_sum);%max(threshold*mad(ccc_sum),1)
[pks,locs]=find_peaks(ccc_sum,'minpeakheight',peak_threshold,'minpeakdistance',6*base_freq);
peak_times=[time(locs)]';
index = find(peak_times < toss_value);
peak_times(index) = [];
peak_times_tosave=[ones(length(locs),1)*str2num(char(YEAR)),ones(length(locs),1)*str2num(DAY),time(locs)',pks'];
if(~isempty(peak_times_tosave))
    peak_times_tosave;
    index = find(peak_times_tosave(:,3) < toss_value);
    peak_times_tosave(index,:) = []
end
    disp(['Finished summing Correlations for day ',DAY,' of Year ',char(YEAR),'. Threshold for the day is ',num2str(peak_threshold),'.']);
    multisum_savename = sprintf('./multisum/%s/%s.%04d.%03d.mat',template,template,YR,DDD);

directory_check = sprintf('./multisum/%s',template);
if exist(directory_check,'dir') ~=7;
    mkdir(directory_check);
    fprintf('%s directory created\n',directory_check);
end
save(multisum_savename,'ccc_sum');
end
