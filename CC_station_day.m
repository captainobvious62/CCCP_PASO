
function [time,ccc_station] = CC_station_day(id,network,station,YEAR,DDD,CHA_E,CHA_N,CHA_Z,FREQ)
% id = '25_Nov'
% YEAR = 2011
% DDD = 121
% station = 'N54A'
% network = 'TA'

YEAR = num2str(YEAR);

DDD = sprintf('%03d',DDD);
%40 Hz for 1 day, in seconds
time=0:1/FREQ:86400;

%Bandpass Filter
high_bp=0.8*(FREQ/2);
low_bp=1;

comp = [0,0,0];
LOC = '*';



fprintf('CC station Day %s\n',datestr(now));
fprintf('%s %s %s %s\n',network,station,YEAR,DDD);



isZero = [0,0,0];
if exist([network,'/',station,'/mseed/',station,'.',CHA_E,'.',num2str(YEAR),'.',num2str(DDD)],'file')
    if exist([network,'/',station,'/Templates/E/template_',id,'.mat'],'file')
        load([network,'/',station,'/Templates/E/template_',id,'.mat'])
        disp('E Template Loaded')
    else
        template_savename = sprintf('%s/%s/%s/Templates/%s/template_%s.%s.%s.mat',network,station,CHA_E,id,id,station,CHA_E)
        %template_savename = sprintf('%s/%s/Templates/%s.%s.%s.mat',network,station,id,CHA_E);
        load(template_savename);
        disp('E Template Loaded')
        wf_Temp = filter_waveform_BP(wf_Temp,1,100);
        timevec =get(wf_Temp,'timevector');
        timevec = timevec - datenum(datestr(timevec(1),1));
        timevec = timevec *86400;
        template_E = [timevec,get(wf_Temp,'data')];
        data_savename = sprintf('%s/%s/Templates/E/template_%s.mat',network,station,id);
        save(data_savename,'template_E');
    end
    % strcat([char(network),'/',char(station),'/mseed/',char(station),'.',CHA_E,'.',YEAR,'.',DDD])
    try
        E_seed = rdmseed(strcat([char(network),'/',char(station),'/mseed/',char(station),'.',CHA_E,'.',num2str(YEAR),'.',num2str(DDD)]));
    catch exception
        disp('mseed value is zero')
        isZero(1) = 1;
    end
    if isZero(1) == 0
        disp([CHA_E,' exists'])
        E_time_vec=datevec(cat(1,E_seed.t));
        tag=median(E_time_vec(:,3));
        good_day_E=find(E_time_vec(:,3)==tag);
        E_time=sum([[zeros(length(E_time_vec(good_day_E)),1),zeros(length(E_time_vec(good_day_E)),1),...
            zeros(length(E_time_vec(good_day_E)),1),3600*ones(length(E_time_vec(good_day_E)),1),...
            60*ones(length(E_time_vec(good_day_E)),1),ones(length(E_time_vec(good_day_E)),1)]'.*E_time_vec(good_day_E,:)'])';
        [B_E,I_E,J]=unique(E_time,'first');
        temp=cat(1,E_seed.d);
        E_data=temp(intersect(good_day_E,I_E));
        clear temp
        E_bp=bandpass(E_data,low_bp,high_bp,1/E_seed(1).SampleRate,3);
        if length(I_E) ~= length(E_bp)
            if length(E_bp) > 86400*FREQ
                E_bp = E_bp(1:86400*FREQ);
            elseif length(E_bp) < 86400*FREQ
                E_bp(length(E_bp+1):86400*FREQ) = 0;
            end
            ccc_E=normxcorr2(template_E(:,2),E_bp(:));
        else
            ccc_E=normxcorr2(template_E(:,2),E_bp(:));
        end
        clear E_seed E_time_vec E_data E_bp;
        comp(1) = 1;
    end
end

if exist([network,'/',station,'/mseed/',station,'.',CHA_N,'.',num2str(YEAR),'.',num2str(DDD)],'file')
    if exist([network,'/',station,'/Templates/N/template_',id,'.mat'],'file')
        load([network,'/',station,'/Templates/N/template_',id,'.mat'])
        disp('N Template Loaded')
    else
        template_savename = sprintf('%s/%s/%s/Templates/%s/template_%s.%s.%s.mat',network,station,CHA_N,id,id,station,CHA_N)
        %template_savename = sprintf('%s/%s/%s/%s/%s.%s.%s.mat',network,station,CHA_N,id,id,station,CHA_N);
        %template_savename = sprintf('%s/%s/Templates/%s.%s.%s.mat',network,station,id,CHA_N);
        load(template_savename);
        disp('N Template Loaded')
        wf_Temp = filter_waveform_BP(wf_Temp,1,100);
        timevec =get(wf_Temp,'timevector');
        timevec = timevec - datenum(datestr(timevec(1),1));
        timevec = timevec *86400;
        template_N = [timevec,get(wf_Temp,'data')];
        data_savename = sprintf('%s/%s/Templates/N/template_%s.mat',network,station,id);
        save(data_savename,'template_N');
    end
    % st
    %N_seed = rdmseed(strcat(ls([char(station),'/mseed/*BH',COMP,'*',YEAR,'*',DDD])));
    try
        N_seed = rdmseed(strcat([char(network),'/',char(station),'/mseed/',char(station),'.',CHA_N,'.',num2str(YEAR),'.',num2str(DDD)]));
    catch exception
        disp('mseed value is zero')
        isZero(2) = 1;
    end
    if isZero(2) == 0
        disp([CHA_N,' exists'])
        N_time_vec=datevec(cat(1,N_seed.t));
        tag=median(N_time_vec(:,3));
        good_day_N=find(N_time_vec(:,3)==tag);
        N_time=sum([[zeros(length(N_time_vec(good_day_N)),1),zeros(length(N_time_vec(good_day_N)),1),...
            zeros(length(N_time_vec(good_day_N)),1),3600*ones(length(N_time_vec(good_day_N)),1),...
            60*ones(length(N_time_vec(good_day_N)),1),ones(length(N_time_vec(good_day_N)),1)]'.*N_time_vec(good_day_N,:)'])';
        [B_N,I_N,J]=unique(N_time,'first');
        temp=cat(1,N_seed.d);
        N_data=temp(intersect(good_day_N,I_N));
        clear temp;
        N_bp=bandpass(N_data,low_bp,high_bp,1/N_seed(1).SampleRate,3);
        if length(I_N) ~= length(N_bp)
            if length(N_bp) > 86400*FREQ
                N_bp = N_bp(1:86400*FREQ);
            elseif length(N_bp) < 86400*FREQ
                N_bp(length(N_bp+1):86400*FREQ) = 0;
            end
            ccc_N=normxcorr2(template_N(:,2),N_bp(:));
        else
            ccc_N=normxcorr2(template_N(:,2),N_bp(:));
        end
        clear N_seed N_time_vec;
        comp(2) = 1;
    end
end
if exist([network,'/',station,'/mseed/',station,'.',CHA_Z,'.',num2str(YEAR),'.',num2str(DDD)],'file')
    if exist([network,'/',station,'/Templates/Z/template_',id,'.mat'],'file')
        load([network,'/',station,'/Templates/Z/template_',id,'.mat'])
        disp('Z Template Loaded')
    else
        template_savename = sprintf('%s/%s/%s/Templates/%s/template_%s.%s.%s.mat',network,station,CHA_Z,id,id,station,CHA_Z)
        %template_savename = sprintf('%s/%s/%s/%s/%s.%s.%s.mat',network,station,CHA_Z,id,id,station,CHA_Z);
        %template_savename = sprintf('%s/%s/Templates/%s.%s.%s.mat',network,station,id,CHA_Z);
        load(template_savename);
        disp('Z Template Loaded')
        wf_Temp = filter_waveform_BP(wf_Temp,1,100);
        timevec =get(wf_Temp,'timevector');
        timevec = timevec - datenum(datestr(timevec(1),1));
        timevec = timevec *86400;
        template_Z = [timevec,get(wf_Temp,'data')];
        data_savename = sprintf('%s/%s/Templates/Z/template_%s.mat',network,station,id);
        save(data_savename,'template_Z');
    end
    %Z_seed = rdmseed(strcat(ls([char(station),'/mseed/*BH',COMP,'*',YEAR,'*',DAY])));
    try
        Z_seed = rdmseed(strcat([char(network),'/',char(station),'/mseed/',char(station),'.',CHA_Z,'.',num2str(YEAR),'.',num2str(DDD)]));
    catch exception
        disp('mseed value is zero')
        
        isZero(3) = 1;
    end
    if isZero(3) == 0
        disp([CHA_Z,' exists'])
        Z_time_vec=datevec(cat(1,Z_seed.t));
        tag=median(Z_time_vec(:,3));
        good_day_z=find(Z_time_vec(:,3)==tag);
        Z_time=sum([[zeros(length(Z_time_vec(good_day_z)),1),zeros(length(Z_time_vec(good_day_z)),1),...
            zeros(length(Z_time_vec(good_day_z)),1),3600*ones(length(Z_time_vec(good_day_z)),1),...
            60*ones(length(Z_time_vec(good_day_z)),1),ones(length(Z_time_vec(good_day_z)),1)]'.*Z_time_vec(good_day_z,:)'])';
        [B_Z,I_Z,J]=unique(Z_time,'first');
        temp=cat(1,Z_seed.d);
        Z_data=temp(intersect(good_day_z,I_Z));
        clear temp;
        Z_bp=bandpass(Z_data,low_bp,high_bp,1/Z_seed(1).SampleRate,3);
        if isequal(length(I_Z),length(Z_bp)) ~= 1
            if length(Z_bp) > 86400*FREQ
                Z_bp = Z_bp(1:86400*FREQ);
            elseif length(Z_bp) < 86400*FREQ
                Z_bp(length(Z_bp+1):86400*FREQ) = 0;
            end
            ccc_Z=normxcorr2(template_Z(:,2),Z_bp(:));
        else
            ccc_Z=normxcorr2(template_Z(:,2),Z_bp(:));
        end
        clear Z_seed Z_time_vec Z_data Z_bp;
        comp(3) = 1;
    end
end
%for 40 Hz
ccc_station = zeros(1,86400*FREQ+1);
if comp(1) == 1;
    ccc_station=ccc_station + interp1(B_E,ccc_E(1:length(B_E)),time,'nearest');
end
if comp(2) == 1;
    ccc_station = ccc_station + interp1(B_N,ccc_N(1:length(B_N)),time,'nearest');
end
if comp(3) == 1
    ccc_station = ccc_station + interp1(B_Z,ccc_Z(1:length(B_Z)),time,'nearest');
end



