
%% Check and remove duplicates again - Post Alignment

function G = removeDuplicates(G,window)
triggers = get(G,'trig');
flagged = zeros(1,length(triggers));
times = cell(1,length(triggers));
for i = 1:length(triggers)
    ind_trig = triggers(i);
    check = 0;
    
    
    for j = 1:length(triggers);
        if abs(ind_trig - triggers(j)) < window/86400 && j ~= i
            if i > j
                check = check + 1;
            end
            if check ~= 1
                flagged(i) = i;
                times{i} = datestr(triggers(i));
            end
        end
    end
    
end
drop = linspace(1,length(flagged),length(flagged));
drop = drop - flagged;
drop(drop == 0) = [];
G = subset(G,drop);
end