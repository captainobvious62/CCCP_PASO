function results = save_CC_results(results,template_count,peak_times_tosave)
results{template_count} = [results{template_count};peak_times_tosave];
end