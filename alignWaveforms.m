function G = alignWaveforms(correlation_object,pWaveArrival,sWaveArrival,comp)
% Separate detected waveforms from template
C = waveform(correlation_object,1:get(correlation_object,'traces')-1);
% If no picks just return the template
if isempty(C) == 1
	C = waveform(correlation_object,get(correlation_object,'traces'));
end

C = correlation(C);
T = waveform(correlation_object,get(correlation_object,'traces'));
switch comp
    case 'E'
        TC = correlation(T,datenum(sWaveArrival));
    case 'N'
        TC = correlation(T,datenum(sWaveArrival));
    case 'Z'
        TC = correlation(T,datenum(pWaveArrival));
end
G = cat(C,TC);
G = xcorr(G,'interp');
G = adjusttrig(G,'INDEX',get(G,'traces'));
end
