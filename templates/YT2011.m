%This file controls the template event to be used for cross correlation.
%At the moment, the format is rather self explanatory, with the fields as follows:
%Station
%Network
%S Wave arrival time (Template focus time)
%Template name
%Channel list denoting channels of interest
%Move out time (will be automated, if it hasn't already been)
%Note that channel order needs to be Z,N,E

function [template_list,template_names] = YT2011()

Mar17 = struct();


Mar17.station = 'N54A';
Mar17.network = 'TA';
Mar17.pWaveArrival = '2011-03-17 10:53:19.900';
Mar17.sWaveArrival = '2011-03-17 10:53:27.325';
Mar17.template = '17_Mar';
Mar17.trigger = 'S';
Mar17.channel_list = ['BHZ';'BHN';'BHE'];
Mar17.channel_list = cellstr(Mar17.channel_list);
Mar17.freq = 40;
Mar17.location = '*';


Mar17(2).station = 'M54A';
Mar17(2).network = 'TA';
Mar17(2).pWaveArrival = '2011-03-17 10:53:25.100';
Mar17(2).sWaveArrival = '2011-03-17 10:53:36.650';
Mar17(2).trigger = 'S';
Mar17(2).template = '17_Mar';
Mar17(2).channel_list = ['BHZ';'BHN';'BHE'];
Mar17(2).channel_list = cellstr(Mar17(2).channel_list);
Mar17(2).freq = 40;
Mar17(2).location = '*';


Mar17(3).station = 'MCWV';
Mar17(3).network = 'US';
Mar17(3).pWaveArrival = '2011-03-17 10:53:38.200';
Mar17(3).sWaveArrival = '2011-03-17 10:54:01.550';
Mar17(3).trigger = 'S';
Mar17(3).template = '17_Mar';
Mar17(3).channel_list = ['BHZ';'BHN';'BHE'];
Mar17(3).channel_list = cellstr(Mar17(3).channel_list);
Mar17(3).freq = 40;
Mar17(3).location = '*';


Mar17(4).station = 'ACSO';
Mar17(4).network = 'US';
Mar17(4).pWaveArrival = '2011-03-17 10:53:43.100';
Mar17(4).sWaveArrival = '2011-03-17 10:54:09.100';
Mar17(4).template = '17_Mar';
Mar17(4).trigger = 'S';
Mar17(4).channel_list = ['BHZ';'BHN';'BHE'];
Mar17(4).channel_list = cellstr(Mar17(4).channel_list);
Mar17(4).freq = 40;
Mar17(4).location = '*';


Mar17(5).station = 'ERPA';
Mar17(5).network = 'US';
Mar17(5).pWaveArrival = '2011-03-17 10:53:30.60';
Mar17(5).sWaveArrival = '2011-03-17 10:53:43.80';
Mar17(5).trigger = 'S';
Mar17(5).template = '17_Mar';
Mar17(5).channel_list = ['BHZ';'BHN';'BHE'];
Mar17(5).channel_list = cellstr(Mar17(5).channel_list);
Mar17(5).freq = 40;
Mar17(5).location = '*';


Mar17(6).station = 'O56A';
Mar17(6).network = 'TA';
Mar17(6).template = '17_Mar';
Mar17(6).pWaveArrival = '2011-03-17 10:53:42.40';
Mar17(6).sWaveArrival = '2011-03-17 10:54:06.35';
Mar17(6).trigger = 'S';
Mar17(6).channel_list = ['BHZ';'BHN';'BHE'];
Mar17(6).channel_list = cellstr(Mar17(6).channel_list);
Mar17(6).freq = 40;
Mar17(6).location = '*';


Nov25 = struct();


Nov25.station = 'N54A';
Nov25.network = 'TA';
Nov25.pWaveArrival = '2011-11-25 06:47:37.400';
Nov25.sWaveArrival = '2011-11-25 06:47:45.050';
Nov25.template = '25_Nov';
Nov25.trigger = 'S';
Nov25.channel_list = ['BHZ';'BHN';'BHE'];
Nov25.channel_list = cellstr(Nov25.channel_list);
Nov25.freq = 40;
Nov25.location = '*';


Nov25(2).station = 'ACSO';
Nov25(2).network = 'US';
Nov25(2).pWaveArrival = '2011-11-25 06:48:01.310';
Nov25(2).sWaveArrival = '2011-11-25 06:48:25.900';
Nov25(2).template = '25_Nov';
Nov25(2).trigger = 'S';
Nov25(2).channel_list = ['BHZ';'BH2';'BH1'];
Nov25(2).channel_list = cellstr(Nov25(2).channel_list);
Nov25(2).freq = 40;
Nov25(2).location = '*';


Nov25(3).station = 'O56A';
Nov25(3).network = 'TA';
Nov25(3).pWaveArrival = '2011-11-25 06:47:59.675';
Nov25(3).sWaveArrival = '2011-11-25 06:48:26.925';
Nov25(3).trigger = 'S';
Nov25(3).template = '25_Nov';
Nov25(3).channel_list = ['BHZ';'BHN';'BHE'];
Nov25(3).channel_list = cellstr(Nov25(3).channel_list);
Nov25(3).freq = 40;
Nov25(3).location = '*';


Nov25(4).station = 'MCWV';
Nov25(4).network = 'US';
Nov25(4).pWaveArrival = '2011-11-25 06:47:55.730';
Nov25(4).sWaveArrival = '2011-11-25 06:48:17.750';
Nov25(4).template = '25_Nov';
Nov25(4).trigger = 'S';
Nov25(4).channel_list = ['BHZ';'BH2';'BH1'];
Nov25(4).channel_list = cellstr(Nov25(4).channel_list);
Nov25(4).freq = 40;
Nov25(4).location = '*';


Nov25(5).station = 'ERPA';
Nov25(5).network = 'US';
Nov25(5).pWaveArrival = '2011-11-25 06:47:47.400';
Nov25(5).sWaveArrival = '2011-11-25 06:48:01.625';
Nov25(5).trigger = 'S';
Nov25(5).template = '25_Nov';
Nov25(5).channel_list = ['BHZ';'BH2';'BH1'];
Nov25(5).channel_list = cellstr(Nov25(5).channel_list);
Nov25(5).freq = 40;
Nov25(5).location = '*';


Nov25(6).station = 'M54A';
Nov25(6).network = 'TA';
Nov25(6).pWaveArrival = '2011-11-25 06:47:42.675';
Nov25(6).sWaveArrival = '2011-11-25 06:47:53.875';
Nov25(6).trigger = 'S';
Nov25(6).template = '25_Nov';
Nov25(6).channel_list = ['BHZ';'BHN';'BHE'];
Nov25(6).channel_list = cellstr(Nov25(6).channel_list);
Nov25(6).freq = 40;
Nov25(6).location = '*';

template_names = {'17_Mar';'25_Nov'};
template_list = {Mar17;Nov25};

end
