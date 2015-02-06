%% Check to ensure P/S - Wave arrival is covered

function G = coverPSinterval(G,pWaveArrival,sWaveArrival,comp)

triggers = get(G,'trig');
flagged = zeros(1,length(triggers));
for i = 1:length(triggers)
    wave = waveform(G,i);
    
    %start of snippet should be before arrival time
    switch comp
        case 'Z'
            %end of snippet should be after arrival time
            if get(wave,'END') < triggers(i)
                flagged(i) = i;
            end
            
            if triggers(i) - (datenum(sWaveArrival)-datenum(pWaveArrival)) < get(wave,'start')
                flagged(i) = i;
            end
            
        case 'N'
            if get(wave,'start') > triggers(i)
                flagged(i) = i;
            end
            if triggers(i) - (datenum(pWaveArrival)-datenum(sWaveArrival)) > get(wave,'END')
                flagged(i) = i;
            end
        case 'E'
            if get(wave,'start') > triggers(i)
                flagged(i) = i;
            end
            if triggers(i) - (datenum(pWaveArrival)-datenum(sWaveArrival)) > get(wave,'END')
                flagged(i) = i;
            end
    end
end
drop = linspace(1,length(flagged),length(flagged));
drop = drop - flagged;
drop(drop == 0) = [];
G = subset(G,drop);
end