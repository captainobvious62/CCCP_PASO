% CCCP Step I
%
% Results are generated and outputted in both human and machine readable
% formats.
%
% Combine Results - Step I

result_savename = sprintf...
    ('./Results/Combined_Results_%s_to_%s.mat',...
    datestr(first_date),datestr(last_date));
all_results_savename = sprintf...
    ('./Results/Combined_Results_%s_to_%s.txt',datestr(first_date),...
    datestr(last_date));
printout_savename = sprintf...
    ('./Results/Printout_Combined_Results_%s_to_%s.mat',...
    datestr(first_date),datestr(last_date));
printout_savename_txt = sprintf...
    ('./Results/Printout_Combined_Results_%s_to_%s.txt',...
    datestr(first_date),datestr(last_date));
results = cell(1,length(template_list));
printout_results = cell(1,length(template_list));
all_results = cellstr({'Year','DOY','Seconds',...
    'CC Value','Template','Zulu @ Nearest'});
txt_results = all_results;
txt_results(7) = cellstr({'Template'});
for template_count = 1:length(template_list);
    
    station_list = template_list{template_count};
    template = template_names{template_count};
    template_results_savename = sprintf('Results/%s/%s.%s_to_%s.mat',...
        template,template,datestr(first_date),datestr(last_date));
    template_results = load(template_results_savename);
    total_results = [];
    fprintf('Template %s\n',template)
    for i = 1:(last_date-first_date)+1
        
        if isfield(template_results,'print_results') == 1
            template_results.template_results = template_results.print_results;
            template_results = rmfield(template_results,'print_results');
        end
        total_results = [total_results;template_results.template_results];
    end
    if isempty(total_results) ~=1
        mat_dates = doy2date(total_results(:,2),total_results(:,1)) +total_results(:,3)/86400;total_results = [total_results mat_dates];
        
        results{template_count} = total_results;
        %total_results_to_print = [total_results,results{template_count}(:,1),results{template_count}(:,2)+results{template_count}(:,3)];
        %total_results_to_print = sortrows(total_results_to_print,1);
        total_results = sortrows(total_results,6);
        names = cell(length(total_results(:,1)),1);
        for j = 1:length(total_results(:,1))
            names{j} = template;
        end
        printout_results{template_count} = {total_results,names};
        print_text_savename = sprintf('./Results/%s/%s.%s_to_%s.txt',template,template,datestr(first_date),datestr(last_date));
        print_results  = printout_results{template_count}{1};
        
        A = cellstr(num2str(print_results(:,1)));
        B = cellstr(num2str(print_results(:,2)));
        C = cellstr(num2str(print_results(:,3))); 
	D = cellstr(num2str(print_results(:,4)));
	E = cellstr(num2str(print_results(:,5)));
        F = cellstr(datestr(print_results(:,6)));
	G = cellstr(names);
        header =cellstr({'Year','DOY','Seconds','CC Value', 'MATLAB Time',...
            'Zulu @ Nearest'});
	txt_header = header;
	txt_header(7) = cellstr({'Template'});
        print_cell = [A,B,C,D,E,F];
       	txt_cell = [A,B,C,D,E,F,G];
	txt_results = [txt_results;txt_cell];
	 all_results = [all_results;print_cell];
        printed_cell = [txt_header; txt_cell];
        dlmcell(print_text_savename,printed_cell);
        save(template_results_savename,'print_results');        
    end
end
save(result_savename,'results');
cell2csv(printout_savename_txt,txt_results)
save(all_results_savename,'all_results');


