function  saveresults_CCC(i,first_date,last_date,peak_times_tosave)
result_savename = sprintf('./Results/%s_to_%s.mat',datestr(first_date),datestr(last_date));
if exist(result_savename) ~= 2
    results = cell(1,(last_date-first_date)+1);
else
   results = load(result_savename);
   results = results.results;
end
results{(last_date-i)+1} = peak_times_tosave;
save(result_savename,'results');
end