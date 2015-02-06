function template_results = saveresults_inside(i,template_count,peak_times_tosave,example_station,first_date,last_date)
template_results_savename = sprintf('./Results/%s/%s.%s_to_%s.mat',example_station.template,example_station.template,datestr(first_date),datestr(last_date));
directory_check = sprintf('./Results/%s',example_station.template);
if exist(directory_check,'dir') ~= 7;
    mkdir(directory_check);
    fprintf('Result directory created \n');
end

times = zeros(length(peak_times_tosave(:,1)),1);
for j = 1:length(times)
    times(j) = doy2date(peak_times_tosave(j,2),peak_times_tosave(j,1)) + peak_times_tosave(j,3)/86400;
end
peak_times_tosave(:,5) = times;



if exist(template_results_savename,'file') == 0;
    template_results = peak_times_tosave;
else
    template_results = load(template_results_savename);
    
    if isfield(template_results,'print_results') == 1
        template_results = template_results.print_results;
    elseif isfield(template_results,'template_results') == 1
        template_results = template_results.template_results;
    end
    
    
    
    template_results = [template_results; peak_times_tosave];
end
save(template_results_savename,'template_results');

end
