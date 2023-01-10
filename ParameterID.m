function [ts,yl,yh,tau] = ParameterID(input,opt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Program Description 
% This program takes a set of time and cooling/heating data and calculates
% the yl, yh, ts and tau values for the curves and returns the values. 
% 
% Function Call
% ParameterID(data)
%
% Input Arguments
% data, two column data set containing values for time and temperature from a
% thermocouple.
% opt, heating or cooling option
%
% Output Arguments
% yl (degreeF), yh (degreeF), ts (s), tau (s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ____________________
%% INITIALIZATION 

%copy the two columns of data
time=input(:,1);
temp=input(:,2);

%% ____________________
%% CALCULATIONS & FORMATTED TEXT & FIGURE DISPLAYS
%smoothing
index = 1; %initialize index for smoothing
data = 1:length(temp); %initialize smoothed data vector

while index < (length(time)-5) %calculate moving average with 10 point window until last 10 points of data set
    avgvalues = [temp(index),temp(index+1),temp(index+2),temp(index+3)];
    data(index) = sum(avgvalues)/4;
    index = index + 1;
end
while index >= (length(time)-5) && index <=length(time) %calculate moving average with 10 point window for last 10 points of data set
    avgvalues = [temp(index),temp(index-1),temp(index-2),temp(index-3)];
    data(index) = sum(avgvalues)/4;
    index = index + 1;
end

%calculating slope throughout function
index2 = 1; %set new index
slope = 1:length(data); %initialize slope vector
while index2 < (length(data)-10) %calculate slope using values spaced 10 points apart
    slope(index2) = (data(index2+10)-data(index2))/(time(index2+10)-time(index2)); %compute slope y2-y1/x2-x1   
    index2 = index2 + 1; %increment
end
while index2 >= (length(time)-10) && index2 <=length(time) %calculating slope spaced 10 points apart in last 150 points of data set
    slope(index2) = (data(index2)-data(index2-10))/(time(index2)-time(index2-10)); %compute slope y2-y1/x2-x1      
    index2 = index2 + 1; %increment
end

%calculation for ts, yl and yh
if opt == 1 %perform for heating curve
    ts = time((slope == max(slope)));
    x=find(time==ts);
    yl = mean(temp(1:x));
    yh = mean(temp(x+20:end));
    yTau = yl + 0.632*(yh-yl);
    
elseif opt == 2 %perform for cooling curve
    ts = time((slope == min(slope)));
    x=find(time==ts);
    yh = mean(temp(1:x));
    yl = mean(temp(x+20:end));
    yTau = yh - (0.632)*(yh-yl);
end

%calculattion for tau: find the upper and lower bond of time where the y
%values are within the range of yTau +- 0.15 degree 
j = x; %check y from ts
while temp(j)-yTau>0.15  
    j=j+1;
end
tlow=time(j); %lower bond of time

i = length(temp); %check y from the last value
while temp(i)-yTau>0.15
      i=i-1;
end
tup=time(i);  %upper bond of time

if opt==1 %perform for heating
    tau=(tlow+tup)/2-ts;
elseif opt==2 %perform for cooling
    tau=tlow-ts;
end

fprintf("The parameters are yl = %.2f (degreeF), yh = %.2f (degreeF), ts = %.2f (s), tau = %.1f (s)\n",yl,yh,ts,tau)
