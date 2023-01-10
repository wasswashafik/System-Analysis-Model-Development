%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Program Description 
% calulate the parameters of four data sets of temperature changes and use
% them to make estimation curve. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ____________________
%% INITIALIZATION  

%inmpotring data from the files
heat=load('Data_HeatingTimeHistory.csv');
cool=load('Data_CoolingTimeHistory.csv');

%% ____________________
%% CALCULATIONS & FORMATTED TEXT & FIGURE DISPLAYS

%heating calculations
fprintf("Calculation for heating data: \n")
[ts_h,yl_h,yh_h,tau_h]=ParameterID(heat,1);
[y_t_h]=Piecewise(heat,ts_h,yl_h,yh_h,tau_h,1);
[SSE_h] = SSEmod(heat,y_t_h);
fprintf("\n")

%cooling calculations
fprintf("Calculation for cooling data: \n")
[ts_c,yl_c,yh_c,tau_c]=ParameterID(cool,2);
[y_t_c]=Piecewise(cool,ts_c,yl_c,yh_c,tau_c,2);
[SSE_c] = SSEmod(cool,y_t_c);
fprintf("\n")

%call plot function
Plots(heat,cool,y_t_h,y_t_c)

%% ANALYSIS
%% -- Q1
% For heating data, comparing our result to the given result, the 
% parameters are yl = -4.58 (degreeF), yh = -3.13 (degreeF), 
% ts = 15.70 (s), tau = 0.4 (s). the yl, yh and ts values are about 0.03
% degreeF off from the given values, while the tau value is te same as
% given. From the above observation, out code is quiet accurate on
% estimation.
%% -- Q2
% For the cooling data, comparing our result to the given result, the 
% parameters are yl = 0.51 (degreeF), yh = 0.88 (degreeF), ts = 7.40 (s), 
% tau = 0.4 (s). The values fr yl and yh are ver close to the given values,
% while ts is 0.5s less than the given value. The tau value is the same as
% the given value. Since our code doesnot recognize outliers, the
% outliers may potentially affecting our inaccuracy.
