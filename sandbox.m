print_results  = [results{1};results{2}];

A = cellstr(num2str(print_results(:,1)));
B = cellstr(num2str(print_results(:,2)));
C = cellstr(num2str(print_results(:,3)));
D = cellstr(num2str(print_results(:,4)));
E = cellstr(num2str(print_results(:,5)));
F = cellstr(datestr(print_results(:,6)));
print_cell = [A,B,C,D,E,F];
cell2csv('testBP.csv',print_cell,',')