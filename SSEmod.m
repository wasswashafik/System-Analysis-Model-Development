function [SSE] = SSEmod(data, y_t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Program Description 
% calculte the mean SSE of the real data an the calculated piecewise
% estimation for each data set
%
% Function Call
% [SSEmod] = SSEmod(data, y_t, inp)
%
% Input Arguments
% data, data of the four given data set
% y_t (degreeF), calculated estimate values from piecewise function
%
% Output Arguments
% SSEmod, the SSE values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ____________________
%% INITIALIZATION 

%copy the temperature data column
a=length(y_t);
y=data(:,2);

%% ____________________
%% CALCULATIONS & FORMATTED TEXT & FIGURE DISPLAYS

SSE = 0; %initialize SSE
for i=1:a
    SSE=SSE+(y(i)-y_t(i))^2;
end
SSE=SSE/a;

fprintf("The SSEmod value is %.4f\n",SSE)

