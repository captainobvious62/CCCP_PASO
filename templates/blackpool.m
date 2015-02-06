% This file controls the template event to be used for cross correlation.
%
% At the moment, the format is rather self explanatory. Templates are
% designed as arrays of structs with the following attributes:
%
% - Station
% - Network
% - P Wave Arrival Time
% - S Wave Arrival Time
% - Arrival (P or S) to trigger alignment on
% - Cell array of channels to use (in ZNE order)
% - Data Location
% - Data sampling rate (Hz)
% - Template Name
%
% Move out time (will be automated, if it hasn't already been)
% Note that channel order needs to be Z,N,E

function [template_list,template_names] = blackpool()

BP1 = struct();

BP1.station = 'CWF';
BP1.network = 'GB';
BP1.pWaveArrival = '2011-04-01 02:34:58.000';
BP1.sWaveArrival = '2011-04-01 02:35:18.200';
BP1.trigger = 'S';
BP1.channel_list = {'BHZ','BHN','BHE'};
BP1.location = '*' ;
BP1.freq = 50;
BP1.template = 'BP1';


BP1(2).station = 'ESK';
BP1(2).network = 'II';
BP1(2).pWaveArrival = '2011-04-01 02:34:57.900';
BP1(2).sWaveArrival = '2011-04-01 02:35:17.100';
BP1(2).trigger = 'S';
BP1(2).channel_list = {'BHZ','BH2','BH1'};
BP1(2).location = '10';   
BP1(2).freq = 40;
BP1(2).template = 'BP1';


BP2 = struct();

	
BP2.station = 'CWF';
BP2.network = 'GB';
BP2.pWaveArrival = '2011-05-27 00:49:56.200';
BP2.sWaveArrival = '2011-05-27 00:50:08.100';
BP2.trigger = 'S';
BP2.channel_list = {'HHZ','HHN','HHE'};
BP2.location = '*' ;
BP2.freq = 100;
BP2.template = 'BP2';


BP2.station = 'ESK';
BP2.network = 'II';
BP2.pWaveArrival = '2011-05-27 00:49:12.72';
BP2.sWaveArrival = '2011-05-27 00:49:32.34';
BP2.trigger = 'S';
BP2.channel_list = {'BHZ','BH2','BH1'};
BP2.location = '10';   
BP2.freq = 40;
BP2.template = 'BP2';


BP2(2).station = 'GAL1';
BP2(2).network = 'GB';
BP2(2).pWaveArrival = '2011-05-27 00:49:12.50';
BP2(2).sWaveArrival = '2011-05-27 00:49:32.91';
BP2(2).trigger = 'S';
BP2(2).channel_list = {'BHZ','BHN','BHE'};
BP2(2).location = '*';    
BP2(2).freq = 50;
BP2(2).template = 'BP2';


% BLKPL3(3).station = 'ESK';
% BLKPL3(3).network = 'II';
% BLKPL3(3).pWaveArrival = '2011-04-01 02:17:55.900';
% BLKPL3(3).sWaveArrival = '2011-04-01 02:35:17.100';
% BLKPL3(3).trigger = 'S';
% BLKPL3(3).channel_list = {'BH1_10','BH2_10','BHZ_10'};
% BLKPL3(3).location = '10'; 

 template_names = {'BP1','BP2'};
 template_list = {BP1,BP2};

end
