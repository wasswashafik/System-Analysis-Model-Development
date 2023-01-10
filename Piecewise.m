function [y_t]=Piecewise(data,ts,yl,yh,tau,opt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Program Description 
% use the piecewise function to calculate an estimated first order response
% of temperature
%
% Function Call
% [y_t]= Piecewise(data,ts,yl,yh,tau,opt)
%
% Input Arguments
% data, from data files
% ts, (s) 
% yl, (degreeF)
% yh, (degreeF)
% tau, (s)
% opt, heating or cooling option
%
% Output Arguments
% y_t, (degreeF) array of esimated temperatures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ____________________
%% INITIALIZATION 

t=data(:,1);
y_t=1:length(t);

%% ____________________
%% CALCULATIONS 

n=1;
%calculation for heating
if opt == 1
    while t(n)<ts
        y_t(n)=yl;
        n=n+1;
    end
    y_t(n)=y_t(n-1);
    while t(n)>=ts && n<length(t)
        y_t(n+1)=yl+(yh-yl)*(1-exp(-(t(n)-ts)/tau));
        n=n+1;
    end
end

%calculation for cooling
m=1;
if opt==2
    while t(m)<ts
        y_t(m)=yh;
        m=m+1;
    end
    y_t(m)=y_t(m-1);
    while t(m)>=ts && m<length(t)
        y_t(m+1)=yl+(yh-yl)*(exp(-(t(m)-ts)/tau));
        m=m+1;
    end
end

