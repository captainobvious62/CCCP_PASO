function [BHZ,BHN,BHE] = produceAlignedCorrelations(NET,CHA_Z,CHA_N,CHA_E,STA,first_date,last_date,pWaveArrival,sWaveArrival,window,template)

warning('off','all');
complist = ['Z';'N';'E'];
complist = cellstr(complist);

% pWaveArrival = '2011-11-25 06:47:37.400';
% sWaveArrival = '2011-11-25 06:47:45.050';
arrivals = cell(1,3);
arrival_sep = abs(datenum(sWaveArrival) - datenum(pWaveArrival))*86400;
%    Z          N        E
%  P-Wave    S-Wave    S-Wave


BHZ = load(['./',NET,'/',STA,'/',CHA_Z,'/',template,'/CO/',datestr(first_date),'.to.',datestr(last_date),'.',STA,'.',CHA_Z,'.mat']);
BHZ = BHZ.data;
comp = complist{1};
BHZ = alignArrivals(BHZ,comp,window,pWaveArrival,sWaveArrival);
arrivals{1} = get(BHZ,'trig');
final_correlation_savename = sprintf('./Results/Correlation_%s_%s_%s.mat',template,STA,CHA_Z);
save(final_correlation_savename,'BHZ');
BHN = load(['./',NET,'/',STA,'/',CHA_N,'/',template,'/CO/',datestr(first_date),'.to.',datestr(last_date),'.',STA,'.',CHA_N,'.mat']);
BHN = BHN.data;
comp = complist{2};
BHN = alignArrivals(BHN,comp,window,pWaveArrival,sWaveArrival);
arrivals{2} = get(BHN,'trig');

BHE = load(['./',NET,'/',STA,'/',CHA_E,'/',template,'/CO/',datestr(first_date),'.to.',datestr(last_date),'.',STA,'.',CHA_E,'.mat']);
BHE = BHE.data;
comp = complist{3};
BHE = alignArrivals(BHE,comp,window,pWaveArrival,sWaveArrival);
arrivals{3} = get(BHE,'trig');

% [Match_BHE, Match_BHZ_E] = match(BHE,BHZ,10);
% [Match_BHN, Match_BHZ_N] = match(BHN,BHZ,10);
% [Match_BHE_N, Match_BHN_E] = match(BHE,BHN,10);
P_Arrivals = [];
S_Arrivals = [];

for i=1:length(arrivals{1})
    E_Comp = 0;
    N_Comp = 0;
    BHZ_Candidate = arrivals{1}(i);
    for j =1:length(arrivals{2})
        if abs(arrivals{1}(i) - arrivals{2}(j))*86400 < 20
            BHN_Candidate = arrivals{2}(j);
            N_Comp = 1;
        end
    end
    for j =1:length(arrivals{3})
        if abs(arrivals{1}(i) - arrivals{3}(j))*86400 < 20
            BHE_Candidate = arrivals{3}(j);
            E_Comp = 1;
        end
    end
    if N_Comp == 1 && E_Comp == 1
        if abs(arrival_sep - abs((BHN_Candidate - BHZ_Candidate))) > abs(arrival_sep - abs((BHE_Candidate - BHZ_Candidate)))
            S_Arrivals(i) = BHE_Candidate;
            P_Arrivals(i) = BHZ_Candidate;
        elseif abs(arrival_sep - abs((BHN_Candidate - BHZ_Candidate))) < abs(arrival_sep - abs((BHE_Candidate - BHZ_Candidate)))
            S_Arrivals(i) = BHN_Candidate;
            P_Arrivals(i) = BHZ_Candidate;
        elseif abs(arrival_sep - abs((BHN_Candidate - BHZ_Candidate))) == abs(arrival_sep - abs((BHE_Candidate - BHZ_Candidate)))
            S_Arrivals(i) = BHE_Candidate;
            P_Arrivals(i) = BHZ_Candidate;
        end
    elseif N_Comp == 1 && E_Comp == 0
        S_Arrivals(i) = BHN_Candidate;
        P_Arrivals(i) = BHZ_Candidate;
    elseif N_Comp == 0 && E_Comp == 1;
        S_Arrivals(i) = BHE_Candidate;
        P_Arrivals(i) = BHZ_Candidate;
    end
end

P_Arrivals(P_Arrivals == 0) = [];

S_Arrivals(S_Arrivals == 0) = [];
P_Arrivals = transpose(P_Arrivals);
S_Arrivals = transpose(S_Arrivals);
S_minus_P = (S_Arrivals - P_Arrivals)*86400;
P_Arrivals(sign(S_minus_P) == -1) = [];
S_Arrivals(sign(S_minus_P) == -1) = [];
S_minus_P(sign(S_minus_P) == -1) = [];



arrival_times = [P_Arrivals S_Arrivals S_minus_P];
end
% for i = 1:length(arrival_times)
%     if sign(arrival_times(i,3)) == -1;
% %         arrival_times(i,:) = [];
% %     end
% % end
%
%
% P = cellstr(datestr(arrival_times(:,1)))
% S = cellstr(datestr(arrival_times(:,2)))
