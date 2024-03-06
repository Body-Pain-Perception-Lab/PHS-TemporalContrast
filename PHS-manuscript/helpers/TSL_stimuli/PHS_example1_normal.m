%% Example of parameters

% t1 = 32;          % initial temperature
% t2 = 42;          % target temperature
% int = 0.1;        % interval (this influences the speed of the animation)
% color = 'r';      % linecolor
% x0 = 0;           % when to start plotting the line on the x axis
% beep = 0          % values: 0 or 1; it indicates whether a beep is presented
% button_press = 1  % values: 0 or 1; it indicates button presses
% bp_color = 'r'    % RGB values; button press color to indicate the perceived quality

path = '/Users/au706616/Documents/Git/PHS-COST/';

%% Plot stimuli
animation_fname = 'TSL_example_normal.gif';
[A,map] = rgb2ind(frame2im(getframe),256);
imwrite(A,map,animation_fname,'LoopCount',65535,'DelayTime',0.01);

reds5 = {'#FEE5D9' '#FCAE91' '#FB6A4A' '#DE2D26' '#A50F15'}; % same colors as in RStudio
blue5 = {'#EFF3FF' '#BDD7E7' '#6BAED6' '#3182BD' '#08519C'}; % same colors as in RStudio

rgb_warm = reds5{2}; 
rgb_cold = blue5{2};
rgb_warmp = reds5{3}; 
rgb_coldp = blue5{3};
gray = [17 17 17];

baseline = 32;
%temperatures = [33.26 30.16 33.58 29.88 33.66 30.31];
temperatures = [38 30.37 38 30.28 38 27.22];
int = 0.1;
% estimated time (plus add 10seconds after the last stimulus
et = sum([abs(temperatures(1)-temperatures(2)) abs(temperatures(3)-temperatures(4)) abs(temperatures(5)-temperatures(6))])*2 + 10;

% creating plot
t = tiledlayout(1,1,'Padding','tight');
t.Units = 'inches';
t.OuterPosition = [0.25 0.25 7 4.5];

nexttile;

% baseline 
xint = 0; % 5s baseline
t1 = baseline; t2 = baseline; beep = 0; button_press = 0;
plot_animatedline(t1, t2, int, reds5{1}, xint, beep, button_press, reds5{1}, et, animation_fname)

% segment 1: WDT 1
% xint = x0;
t1 = baseline; t2 = temperatures(1);  beep = 0; button_press = 0;
plot_animatedline(t1, t2, int, rgb_warm, xint, beep, button_press, rgb_warm, et, animation_fname)
xint = xint + abs(t1-t2); % determine x-axis coordinate where to plot the next segment and where to plot the text
%text(xint-1,temperatures(1)+ 1.5,num2str(temperatures(1)), 'FontSize',12); % add a text (temperature in C) to the plot

% segment 2: return to baseline
t1 = temperatures(1); t2 = baseline; beep = 1; button_press = 0; 
plot_animatedline(t1, t2, int, rgb_warm, xint, beep, button_press, rgb_warm, et, animation_fname)
xint = xint + abs(t1-t2); % determine x coordinate where to plot the next segment

% segment 3: CDT 1
t1 = baseline; t2 = temperatures(2); beep = 0; button_press = 1; 
plot_animatedline(t1, t2, int, rgb_cold, xint, beep, button_press, rgb_cold, et, animation_fname)
xint = xint + abs(t1-t2); % determine x-axis coordinate where to plot the next segment and draw text 
text(xint-1,temperatures(2) - 1.5,num2str(temperatures(2)), 'FontSize',14); % add a text (temperature in C) to the plot

% segment 4: return to baseline
t1 = temperatures(2); t2 = baseline; beep = 0; button_press = 0;
plot_animatedline(t1, t2, int, rgb_cold, xint, beep, button_press, rgb_cold, et, animation_fname)
xint = xint + abs(t1-t2);  % determine x-axis coordinate where to plot the next segment

% segment 5: WDT 2
t1 = baseline; t2 = temperatures(3); beep = 0; button_press = 0;
plot_animatedline(t1, t2, int, rgb_warm, xint, beep, button_press, rgb_warm, et, animation_fname)
xint = xint + abs(t1-t2); % determine x-axis coordinate where to plot the next segment and draw text
%text(xint-1,temperatures(3)+ 1.5,num2str(temperatures(3)), 'FontSize',12);

% segment 6: return to baseline
t1 = temperatures(3); t2 = baseline; beep = 1; button_press = 0; 
plot_animatedline(t1, t2, int, rgb_warm, xint, beep, button_press, rgb_warm, et, animation_fname)
xint = xint + abs(t1-t2); % determine x-axis coordinate where to plot the next segment

% segment 7: CDT 2
t1 = baseline; t2 = temperatures(4); beep = 0; button_press = 1;
plot_animatedline(t1, t2, int, rgb_cold, xint, beep, button_press, rgb_cold, et, animation_fname)
xint = xint + abs(t1-t2); % determine x-axis coordinate where to plot the next segment and draw text
text(xint-1,temperatures(4) - 1.5,num2str(temperatures(4)), 'FontSize',14);

% segment 8: return to baseline
t1 = temperatures(4); t2 = baseline; beep = 0; button_press = 0;
plot_animatedline(t1, t2, int, rgb_cold, xint, beep, button_press, rgb_cold, et, animation_fname)
xint = xint + abs(t1-t2); % determine x-axis coordinate where to plot the next segment

% segment 9: WDT 3
t1 = baseline; t2 = temperatures(5);  beep = 0; button_press = 0;
plot_animatedline(t1, t2, int, rgb_warm, xint, beep, button_press, rgb_warm, et, animation_fname)
xint = xint + abs(t1-t2); % determine x-axis coordinate where to plot the next segment and draw text
%text(xint-1,temperatures(5) + 1.5,num2str(temperatures(5)), 'FontSize',12);

% segment 10: return to baseline
t1 = temperatures(5); t2 = baseline; beep = 1; button_press = 0;
plot_animatedline(t1, t2, int, rgb_warm, xint, beep, button_press, rgb_warm, et, animation_fname)
xint = xint + abs(t1-t2); % determine x-axis coordinate where to plot the next segment

% segment 11: CDT 3
t1 = baseline; t2 = temperatures(6); beep = 0; button_press = 1; 
plot_animatedline(t1, t2, int, rgb_cold, xint, beep, button_press, rgb_warmp, et, animation_fname)
xint = xint + abs(t1-t2); % determine x-axis coordinate where to plot the next segment and draw text
text(xint-1,temperatures(6) - 1.5,num2str(temperatures(6)), 'FontSize',14);

% segment 12: return to baseline
t1 = temperatures(6); t2 = baseline; beep = 0; button_press = 0;
plot_animatedline(t1, t2, int, rgb_cold, xint, beep, button_press, rgb_cold, et, animation_fname)

% title for whole plot
%th = title(t, 'C. Adapted Thermal Sensory Limen Task', ...
%    'FontSize', 16, 'FontWeight', 'Bold');
writeAnimation('PHS_results_181.gif')

%% save figure 
f = gcf;
filename = fullfile([path '/figures'], 'Figure1C.png');
exportgraphics(f,filename, 'Resolution', 600)

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
        x = 0:int:x0;
        y = zeros(1,length(x))+32;
    end
    

    % define plotting options
    set(gca, 'XLim', [0 round(et)], 'YLim', [20 45], 'FontSize', 14) % X-axis and Y-axis limits
    yl = yline(32,'--','baseline', 'LineWidth', 2.5, 'FontSize', 16); % baseline line
    yl.Color = [0.5 0.5 0.5]; % color of the baseline line
    ylabel(['Temperature (' char(0176) 'C)'], 'FontSize', 16)
    xlabel('Time (s)', 'FontSize', 16)
    %title('Adapted Thermal Sensory Limen: Medium Contrast', 'FontSize', 16);
    
    % define what to draw
    stimuli = animatedline('Color', color, 'LineWidth', 3);
    beep_point = animatedline('Color', [0.5 0.5 0.5], 'Marker', 'd', 'MarkerFaceColor', [0.5 0.5 0.5], 'MarkerSize', 12);
    press_point_1 = animatedline('Color', bp_color, 'Marker', 'o', 'MarkerSize', 6);
    press_point_2 = animatedline('Color', bp_color, 'Marker', 'o', 'MarkerFaceColor', bp_color, 'MarkerSize', 12);
          
    % draw line point by point
    for ii = 1:length(x)
        addpoints(stimuli, x(ii), y(ii));
        drawnow
        [A,map] = rgb2ind(frame2im(getframe),256);
        imwrite(A,map,'TSL_example_normal.gif','WriteMode','append','DelayTime',0.01);
    end
    
    % add a diamond to indicate when the beep is presented
    if beep
        addpoints(beep_point, x(end), 32);
        drawnow
        [A,map] = rgb2ind(frame2im(getframe),256);
        imwrite(A,map,'TSL_example_normal.gif','WriteMode','append','DelayTime',0.01);
    end
    
    % add a circle to indicate when there is a butotn press
    if button_press
        addpoints(press_point_1, x(end), t2);
        addpoints(press_point_2, x(end), t2);
        drawnow
        [A,map] = rgb2ind(frame2im(getframe),256);
        imwrite(A,map,'TSL_example_normal.gif','WriteMode','append','DelayTime',0.01);
    end 
end

