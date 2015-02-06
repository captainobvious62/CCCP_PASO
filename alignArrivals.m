


function G = alignArrivals(correlation_object,comp,window,pWaveArrival,sWaveArrival)
%% Drop duplicates
correlation_object = removeDuplicates(correlation_object,window);
%correlation_object = agc(correlation_object);
%% align on P Wave or S wave
base_trig = get(correlation_object,'trig');
base_start = get(correlation_object,'start');
G = alignWaveforms(correlation_object,pWaveArrival,sWaveArrival,comp);
G = crop(G,[-20,20]);
G = alignWaveforms(correlation_object,pWaveArrival,sWaveArrival,comp);
%% Check and remove duplicates again - Post Alignment
G = removeDuplicates(G,window);

%% Check to ensure P/S - Wave arrival is covered
G = coverPSinterval(G,pWaveArrival,sWaveArrival,comp);

%% Remove adjustments greater than the length of the template
adj_trig = get(G,'trig');
adj_start = get(G,'start');
flagged = zeros(1,length(adj_trig));
diff = zeros(1,length(adj_trig));

for i = 1:length(adj_trig)
    for j = 1:length(base_trig)
        if base_start(j) == adj_start(i)
            diff(i) = abs(adj_trig(i) - base_trig(j))*86400;
        end
        if diff(i) > get(waveform(G,get(G,'traces')),'DURATION_EPOCH')
            flagged(i) = i;
        end               
    end
end

%delta_trig = [adj_trig transpose(diff)];
drop = linspace(1,length(flagged),length(flagged));
drop = drop - flagged;
drop(drop == 0) = [];
G = subset(G,drop);

end
