%% Example of parameters

% t1 = 32;          % initial temperature
% t2 = 42;          % target temperature
% int = 0.1;        % interval (this influences the speed of the animation)
% color = 'r';      % linecolor
% x0 = 0;           % when to start plotting the line on the x axis
% beep = 0          % values: 0 or 1; it indicates whether a beep is presented
% button_press = 1  % values: 0 or 1; it indicates button presses
% bp_color = 'r'    % RGB values; button press color to indicate the perceived quality

%% Plot stimul
animation_fname = 'TSL_example.gif';
[A,map] = rgb2ind(frame2im(getframe),256);
imwrite(A,map,animation_fname,'LoopCount',65535,'DelayTime',0.01);

x0 = 0; % start timeline from 0
rgb_warm = [0.8500 0.3250 0.0980];
rgb_cold = [0 0.4470 0.7410];
gray = [0.5 0.5 0.5];

% segment 1: WDT 1
t1 = 32; t2 = 42; int = 0.1; beep = 0; button_press = 1; bp_color = rgb_warm;
plot_animatedline(t1, t2, int, rgb_warm, x0, beep, button_press, bp_color, animation_fname)

% segment 2: return to baseline
xint = x0 + abs(t1-t2);
t1 = 42; t2 = 32; beep = 1; button_press = 0; bp_color = 0;
plot_animatedline(t1, t2, int, rgb_warm, xint, beep, button_press, bp_color, animation_fname)

% segment 3: CDT 1
xint = xint + abs(t1-t2); beep = 0; button_press = 1; bp_color = rgb_warm;
t1 = 32; t2 = 20; x0 = abs(t1-t2) + x0;
plot_animatedline(t1, t2, int, rgb_cold, xint, beep, button_press, bp_color, animation_fname)

% segment 4: return to baseline
% xint = xint + abs(t1-t2); beep = 0; button_press = 0; bp_color = 0;
% t1 = 20; t2 = 32; x0 = abs(t1-t2) + x0;
% plot_animatedline(t1, t2, int, rgb_cold, xint, beep, button_press, bp_color)

writeAnimation('TSL_example.gif')
%% function used for plotting the animated lines
function plot_animatedline(t1,t2,int, color, x0, beep, button_press, bp_color, animation_fname)
    
    if t1 < t2
        y = t1:int:t2; % increasing temperatures
    else
        y = t1:-int:t2;  % decreasing temperatures
    end

    x = x0:0.1:x0+abs(t2-t1);

    stimuli = animatedline('Color', color, 'LineWidth', 3);
    
    % define plotting options
    set(gca, 'XLim', [0 45], 'YLim', [0 50], 'FontSize',12) % X-axis and Y-axis limits
    yl = yline(32,'--','baseline', 'LineWidth', 2, 'FontSize',12); % baseline line
    yl.Color = [0.5 0.5 0.5]; % color of the baseline line
    ylabel(['Temperature (' char(0176) 'C)'], 'FontSize',14)
    xlabel('Time (s)', 'FontSize',14)
    
    for ii = 1:length(x)
        addpoints(stimuli, x(ii), y(ii));
        drawnow
        [A,map] = rgb2ind(frame2im(getframe),256);
        imwrite(A,map,'TSL_example.gif','WriteMode','append','DelayTime',0.01);
    end
    
    if beep
        beep = animatedline('Color', [0.5 0.5 0.5], 'Marker', 'd', 'MarkerFaceColor', [0.5 0.5 0.5], 'MarkerSize', 10);
        addpoints(beep, x(end), 32);
        [A,map] = rgb2ind(frame2im(getframe),256);
        imwrite(A,map,'TSL_example.gif','WriteMode','append','DelayTime',0.01);
    end
    
    if button_press
        press = animatedline('Color', bp_color, 'Marker', 'o', 'MarkerFaceColor', bp_color, 'MarkerSize', 10);
        addpoints(press, x(end), t2);
        [A,map] = rgb2ind(frame2im(getframe),256);
        imwrite(A,map,'TSL_example.gif','WriteMode','append','DelayTime',0.01);
    end
    
end

