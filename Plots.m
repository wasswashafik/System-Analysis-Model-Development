function [] = Plots(heat,cool,y_t_h,y_t_c)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Program Description 
% plot the four data set and also the estimations made by the piecewise
% funtion
%
% Function Call
% Plots(heat, cool,y_t_c,y_t_h)
%
% Input Arguments
% heat, heating data set
% cool, cooling data set
% y_t_h, piecewise model for heating
% y_t_c, piecewise model for cooling
%
% Output Arguments
% None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ____________________
%% INITIALIZATION 

%copy the columns of the imported data
H_x = heat(:,1);
H_y = heat(:,2);

C_x = cool(:,1);
C_y = cool(:,2);


%% ____________________
%% CALCULATIONS & FORMATTED TEXT & FIGURE DISPLAYS

%plot heating
figure(1)
subplot(2,1,1)
plot(H_x, H_y, 'r.')
hold on
plot(H_x,y_t_h,'k')
xlabel('Time (sec)')
ylabel('Temperature (Fahrenheit)')
title('Heating data')
legend('meaured data','piecewise estimation','location','best')
hold off
grid on

%plot cooling
subplot(2,1,2)
plot(C_x, C_y, 'b.')
hold on
plot(C_x,y_t_c,'k')
xlabel('Time (sec)')
ylabel('Temperature (Fahrenheit)')
title('Cooling data')
legend('meaured data','piecewise estimation','location','best')
hold off
grid on

