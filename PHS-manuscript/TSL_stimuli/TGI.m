%% Example of parameters

% t1 = 32;          % initial temperature
% t2 = 42;          % target temperature
% int = 0.1;        % interval (this influences the speed of the animation)
% color = 'r';      % linecolor
% x0 = 0;           % when to start plotting the line on the x axis
% beep = 0          % values: 0 or 1; it indicates whether a beep is presented
% button_press = 1  % values: 0 or 1; it indicates button presses
% bp_color = 'r'    % RGB values; button press color to indicate the perceived quality

%% Plot stimuli
reds5 = {'#FEE5D9' '#FCAE91' '#FB6A4A' '#DE2D26' '#A50F15'}; % same colors as in RStudio
blue5 = {'#EFF3FF' '#BDD7E7' '#6BAED6' '#3182BD' '#08519C'}; % same colors as in RStudio

rgb_warm = reds5{2}; 
rgb_cold = blue5{2};
rgb_warmp = reds5{3}; 
rgb_coldp = blue5{3};
gray = [17 17 17];

baseline = 30;
%temperatures = [33.26 30.16 33.58 29.88 33.66 30.31];
warm_temperature = 40;
cold_temperature = 20;
int = 0.1;
xint = 5; % 10s baseline
% estimated time (plus add 10seconds after the last stimulus
%et = sum([abs(mean_temperatures(1)-mean_temperatures(2)) abs(mean_temperatures(3)-mean_temperatures(4)) abs(mean_temperatures(5)-mean_temperatures(6))])*2 + 10 + xint;
et = 70;
tgi_duration = 30;
%%
animation_fname = 'TGI_ver1.gif';
[A,map] = rgb2ind(frame2im(getframe),256);
imwrite(A,map,animation_fname,'LoopCount',65535,'DelayTime',0.01);

% % Legend
hold on
plot(3, 49, 'Color', [0.5 0.5 0.5], 'Marker', 'd', 'MarkerFaceColor', [0.5 0.5 0.5], 'MarkerSize', 10); % diamond
text(5, 49, 'Cue for ratings', 'FontSize',12)
plot(3, 47, 'Color', reds5{5}, 'Marker', 'o', 'MarkerSize', 10);
plot(3, 47, 'Color', reds5{5}, 'Marker', 'o', 'MarkerFaceColor', reds5{4}, 'MarkerSize', 8);
text(5, 47, 'Ratings or Temperature Match', 'FontSize',12)

plot(40, 44, 'Color', reds5{5}, 'Marker', 'o', 'MarkerSize', 10);
plot(40, 44, 'Color', reds5{5}, 'Marker', 'o', 'MarkerFaceColor', reds5{4}, 'MarkerSize', 8);

%baseline 
t1 = baseline; t2 = baseline; beep = 0; button_press = 0;
plot_animatedline(t1, t2, int, reds5{1}, xint, beep, button_press, reds5{1}, et, animation_fname)

% segment 1: WDT 1
t1 = baseline; t2 = warm_temperature(1);  beep = 0; button_press = 0;
plot_animatedline(t1, t2, int, rgb_warm, xint, beep, button_press, rgb_warmp, et, animation_fname)
%xint = xint + abs(t1-t2); % determine x-axis coordinate where to plot the next segment and where to plot the text

% segment 3: CDT 1
t1 = baseline; t2 = cold_temperature(1); beep = 0; button_press = 0; 
plot_animatedline(t1, t2, int, rgb_cold, xint, beep, button_press, rgb_coldp, et, animation_fname)
xint = xint + abs(t1-t2); % determine x-axis coordinate where to plot the next segment and draw text 

% segment 4: return to baseline
t1 = cold_temperature(1); t2 = cold_temperature(1); beep = 1; button_press = 0;
plot_animatedline(t1, t2, int, rgb_cold, xint, beep, button_press, rgb_coldp, et, animation_fname)
xint = xint + abs(t1-t2);  % determine x-axis coordinate where to plot the next segment

% segment 5: WDT 2
t1 = warm_temperature(1); t2 = warm_temperature(1); beep = 1; button_press = 0;
plot_animatedline(t1, t2, int, rgb_warm, xint, beep, button_press, rgb_warmp, et, animation_fname)
xint = xint + abs(t1-t2) + tgi_duration;  % determine x-axis coordinate where to plot the next segment

% segment 6: WDT 2
t1 = warm_temperature(1); t2 = baseline; beep = 0; button_press = 0;
plot_animatedline(t1, t2, int, rgb_warm, xint, beep, button_press, rgb_warmp, et, animation_fname)

% segment 6: CDT 2
t1 = cold_temperature(1); t2 = baseline; beep = 0; button_press = 0;
plot_animatedline(t1, t2, int, rgb_cold, xint, beep, button_press, rgb_coldp, et, animation_fname)

writeAnimation(animation_fname)
%% function used for plotting the animated lines
function plot_animatedline(t1,t2,int, color, x0, beep, button_press, bp_color, et, animation_fname)
    
    % define x-axis and y-axis datapoints
    if t1 < t2
        y = t1:int:t2; % increasing temperatures
        x = x0:int:x0+abs(t2-t1);
    elseif t1 > t2
        y = t1:-int:t2;  % decreasing temperatures
        x = x0:int:x0+abs(t2-t1);
    elseif t1 == t2
        if x0 == 5
            x = 0:int:x0;
            y = zeros(1,length(x))+t1;
        else
            x = x0:int:x0+30;
            y = zeros(1,length(x))+t1;
        end
    end

    % define plotting options
    set(gca, 'XLim', [0 round(et)], 'YLim', [0 50], 'FontSize',12) % X-axis and Y-axis limits
    yl = yline(30,'--','baseline', 'LineWidth', 2, 'FontSize',12); % baseline line
    yl.Color = [0.5 0.5 0.5]; % color of the baseline line
    ylabel(['Temperature (' char(0176) 'C)'], 'FontSize',14)
    xlabel('Time (s)', 'FontSize',14)
    %title('Adapted Thermal Sensory Limen (TSL)', 'FontSize',14)
    
    % define what to draw
    stimuli = animatedline('Color', color, 'LineWidth', 3);
    beep_point = animatedline('Color', [0.5 0.5 0.5], 'Marker', 'd', 'MarkerFaceColor', [0.5 0.5 0.5], 'MarkerSize', 10);
    press_point_1 = animatedline('Color', bp_color, 'Marker', 'o', 'MarkerSize', 10);
    press_point_2 = animatedline('Color', bp_color, 'Marker', 'o', 'MarkerFaceColor', color, 'MarkerSize', 8);
          
    % draw line point by point
    for ii = 1:length(x)
        addpoints(stimuli, x(ii), y(ii));
        drawnow
        [A,map] = rgb2ind(frame2im(getframe),256);
        imwrite(A,map,animation_fname,'WriteMode','append','DelayTime',0.01);
    end
    
    % add a diamond to indicate when the beep is presented
    if beep
        addpoints(beep_point, 40, 40);
        addpoints(beep_point, 40, 20);
        drawnow
        [A,map] = rgb2ind(frame2im(getframe),256);
        imwrite(A,map,animation_fname,'WriteMode','append','DelayTime',0.01);
    end
    
    % add a circle to indicate when there is a butotn press
    if button_press
        addpoints(press_point_1, x(end), t2);
        addpoints(press_point_2, x(end), t2);
        drawnow
        %if(mod(k,20)==0)
            [A,map] = rgb2ind(frame2im(getframe),256);
            imwrite(A,map,animation_fname,'WriteMode','append','DelayTime',0.01);
        %end
    end
    
end

