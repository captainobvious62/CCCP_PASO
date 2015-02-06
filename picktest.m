headers = zeros(length(picks(:,1)),1);
for i = 1:length(picks(:,1))
    str2double(picks{i,1});
    headers(i,1) = ~isnan(str2double(picks{i,1})) * i;
end
headers(headers ==0) = [];


for i= length(headers) - 1
    event(i) = picks(headers(i):headers(i+1)-1,:)
end

