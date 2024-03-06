%% plotting temperature contrast
function temp_plot(x)
    grayColor = [.5 .5 .5];

% x = plotting array
    hold on
    plot(x, 'LineWidth', 2.5, 'Color', grayColor);
    ylim([0, 50])
    xlim([0, length(x)+1])
    box on
end

