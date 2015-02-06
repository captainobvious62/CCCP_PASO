function clearresults(example_station,first_date,last_date)
template_results_savename = sprintf('./Results/%s/%s.%s_to_%s.mat',example_station.template,example_station.template,datestr(first_date),datestr(last_date));
directory_check = sprintf('./Results/%s',example_station.template);
if exist(directory_check,'dir') ~= 7;
    mkdir(directory_check);
    fprintf('Result directory created \n');
end
template_results = cell(1,(last_date-first_date)+1);

save(template_results_savename,'template_results');

end