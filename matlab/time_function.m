function [time_indicator]=time_function(time_input)

year=round(time_input/10000);
month=round((time_input-year*10000)/100);
day=time_input-year*10000-month*100;

time_indicator=year+((month-1)*30.5+day)/365;

end
