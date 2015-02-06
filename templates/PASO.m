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

function [template_list,template_names] = PASO()
% 2005  4 29 10 28 16.565    35.99434   -120.55386    5.026   0.013   
% 0.005  43   0.011  1.0   21453012  2382     37686    37746

BP1 = struct();

BP1.station = 'CCRB';
BP1.network = 'BP';
BP1.pWaveArrival = '2005-04-29 10:28:17.8540';
BP1.sWaveArrival = '2005-04-29 10:28:18.8120';
BP1.trigger = 'S';
BP1.channel_list = {'DP2','DP3','DP1'};
BP1.location = '*' ;
BP1.freq = 250;
BP1.template = 'BP1';


BP1(2).station = 'EADB';
BP1(2).network = 'BP';
BP1(2).pWaveArrival = '2005-04-29 10:28:20.4390';
BP1(2).sWaveArrival = '2005-04-29 10:28:24.2550';
BP1(2).trigger = 'S';
BP1(2).channel_list = {'DP2','DP3','DP1'};
BP1(2).location = '*';   
BP1(2).freq = 250;
BP1(2).template = 'BP1';

BP1(3).station = 'JCNB';
BP1(3).network = 'BP';
BP1(3).pWaveArrival = '2005-04-29 10:28:19.6601';
BP1(3).sWaveArrival = '2005-04-29 10:28:22.1700';
BP1(3).trigger = 'S';
BP1(3).channel_list = {'DP2','DP3','DP1'};
BP1(3).location = '*';   
BP1(3).freq = 250;
BP1(3).template = 'BP1';


BP1(4).station = 'MMNB';
BP1(4).network = 'BP';
BP1(4).pWaveArrival = '2005-04-29 10:28:18.6056';
BP1(4).sWaveArrival = '2005-04-29 10:28:20.1950';
BP1(4).trigger = 'S';
BP1(4).channel_list = {'DP2','DP3','DP1'};
BP1(4).location = '*';   
BP1(4).freq = 250;
BP1(4).template = 'BP1';


BP1(5).station = 'SCYB';
BP1(5).network = 'BP';
BP1(5).pWaveArrival = '2005-04-29 10:28:17.8687';
BP1(5).sWaveArrival = '2005-04-29 10:28:19.0074';
BP1(5).trigger = 'S';
BP1(5).channel_list = {'DP2','DP3','DP1'};
BP1(5).location = '*';   
BP1(5).freq = 250;
BP1(5).template = 'BP1';

BP1(5).station = 'SMNB';
BP1(5).network = 'BP';
BP1(5).pWaveArrival = '2005-04-29 10:28:17.6821';
BP1(5).sWaveArrival = '2005-04-29 10:28:18.3456';
BP1(5).trigger = 'S';
BP1(5).channel_list = {'DP2','DP3','DP1'};
BP1(5).location = '*';   
BP1(5).freq = 250;
BP1(5).template = 'BP1';

BP1(5).station = 'VARB';
BP1(5).network = 'BP';
BP1(5).pWaveArrival = '2005-04-29 10:28:19.6041';
BP1(5).sWaveArrival = '2005-04-29 10:28:21.7980';
BP1(5).trigger = 'S';
BP1(5).channel_list = {'DP2','DP3','DP1'};
BP1(5).location = '*';   
BP1(5).freq = 250;
BP1(5).template = 'BP1';

BP1(5).station = 'VCAB';
BP1(5).network = 'BP';
BP1(5).pWaveArrival = '2005-04-29 10:28:18.4538';
BP1(5).sWaveArrival = '2005-04-29 10:28:20.2645';
BP1(5).trigger = 'S';
BP1(5).channel_list = {'DP2','DP3','DP1'};
BP1(5).location = '*';   
BP1(5).freq = 250;
BP1(5).template = 'BP1';


BP2 = struct();
% 2005  5  1 17 27 56.269    35.97951   -120.53710    3.318   0.010   0.004
% 35   0.010  1.2   21453408  10026    62866    62926 
 	
BP2.station = 'CCRB';
BP2.network = 'BP';
BP2.pWaveArrival = '2005-05-01 17:27:57.2580';
BP2.sWaveArrival = '2005-05-01 17:27:57.9960';
BP2.trigger = 'S';
BP2.channel_list = {'DP2','DP3','DP3'};
BP2.location = '*' ;
BP2.freq = 250;
BP2.template = 'BP2';


BP2(2).station = 'EADB';
BP2(2).network = 'BP';
BP2(2).pWaveArrival = '2005-05-01 17:27:59.4400';
BP2(2).sWaveArrival = '2005-05-01 17:28:04.2120';
BP2(2).trigger = 'S';
BP2(2).channel_list = {'DP2','DP3','DP3'};
BP2(2).location = '*' ;
BP2(2).freq = 250;
BP2(2).template = 'BP2';

BP2(3).station = 'GHIB';
BP2(3).network = 'BP';
BP2(3).pWaveArrival = '2005-05-01 17:28:01.1660';
BP2(3).sWaveArrival = '2005-05-01 17:28:05.6000';
BP2(3).trigger = 'S';
BP2(3).channel_list = {'DP2','DP3','DP3'};
BP2(3).location = '*' ;
BP2(3).freq = 250;
BP2(3).template = 'BP2';

BP2(4).station = 'JCNB';
BP2(4).network = 'BP';
BP2(4).pWaveArrival = '2005-05-01 17:27:59.9120';
BP2(4).sWaveArrival = '2005-05-01 17:28:00.9190';
BP2(4).trigger = 'S';
BP2(4).channel_list = {'DP2','DP3','DP3'};
BP2(4).location = '*' ;
BP2(4).freq = 250;
BP2(4).template = 'BP2';

BP2(5).station = 'LCCB';
BP2(5).network = 'BP';
BP2(5).pWaveArrival = '2005-05-01 17:27:57.2150';
BP2(5).sWaveArrival = '2005-05-01 17:27:57.9860';
BP2(5).trigger = 'S';
BP2(5).channel_list = {'DP2','DP3','DP3'};
BP2(5).location = '*' ;
BP2(5).freq = 250;
BP2(5).template = 'BP2';

BP2(6).station = 'MMNB';
BP2(6).network = 'BP';
BP2(6).pWaveArrival = '2005-05-01 17:27:58.8280';
BP2(6).sWaveArrival = '2005-05-01 17:27:59.0950';
BP2(6).trigger = 'S';
BP2(6).channel_list = {'DP2','DP3','DP3'};
BP2(6).location = '*' ;
BP2(6).freq = 250;
BP2(6).template = 'BP2';

BP2(7).station = 'RMNB';
BP2(7).network = 'BP';
BP2(7).pWaveArrival = '2005-05-01 17:27:58.2070';
BP2(7).sWaveArrival = '2005-05-01 17:27:59.9300';
BP2(7).trigger = 'S';
BP2(7).channel_list = {'DP2','DP3','DP3'};
BP2(7).location = '*' ;
BP2(7).freq = 250;
BP2(7).template = 'BP2';

BP2(8).station = 'SMNB';
BP2(8).network = 'BP';
BP2(8).pWaveArrival = '2005-05-01 17:27:57.3300';
BP2(8).sWaveArrival = '2005-05-01 17:27:58.0330';
BP2(8).trigger = 'S';
BP2(8).channel_list = {'DP2','DP3','DP3'};
BP2(8).location = '*' ;
BP2(8).freq = 250;
BP2(8).template = 'BP2';

BP2(9).station = 'VARB';
BP2(9).network = 'BP';
BP2(9).pWaveArrival = '2005-05-01 17:27:58.8510';
BP2(9).sWaveArrival = '2005-05-01 17:28:00.8310';
BP2(9).trigger = 'S';
BP2(9).channel_list = {'DP2','DP3','DP3'};
BP2(9).location = '*' ;
BP2(9).freq = 250;
BP2(9).template = 'BP2';

BP2(10).station = 'VCAB';
BP2(10).network = 'BP';
BP2(10).pWaveArrival = '2005-05-01 17:27:57.7800';
BP2(10).sWaveArrival = '2005-05-01 17:28:58.9320';
BP2(10).trigger = 'S';
BP2(10).channel_list = {'DP2','DP3','DP3'};
BP2(10).location = '*' ;
BP2(10).freq = 250;
BP2(10).template = 'BP2';



 template_names = {'BP1'};
 template_list = {BP1};

end
