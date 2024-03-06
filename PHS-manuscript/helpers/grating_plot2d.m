%% Plot grating in 2D space
function grating_plot2d(grating)
    
    % Plot
    x = grating(1,:);
    plot(x, 'LineWidth', 2.5, 'Color', 'k');

    % Set x-axis limits
    xlim([0, 300]);

    % Set y-axis limits
    ylim([0, 1]);

end