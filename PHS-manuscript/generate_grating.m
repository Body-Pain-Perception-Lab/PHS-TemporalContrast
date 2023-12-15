% Draw sine wave gratings
function grating = generate_grating(contrast, colour)
    % Parameters
    imgY = 220;
    imgX = 300; % Image size (pixels)
    spatialFrequency = 0.01; % Spatial frequency (cycles per pixel)
    orientation = 0; % Orientation (degrees)

    % Create meshgrid
    [x, y] = meshgrid(1:imgX, 1:imgY);

    % Convert orientation to radians and create the rotated coordinates
    theta = deg2rad(orientation);
    xr = x * cos(theta) + y * sin(theta);
    yr = -x * sin(theta) + y * cos(theta);

    % Generate sine wave grating
    grating = 0.5 + contrast * 0.5 * sin(2 * pi * spatialFrequency * xr);
     
    % create a colormap
    cm = [1 0 0; 0.8 0 0.2; 0.5 0 0.5; 0.2 0 0.8; 0 0 1];
    
    %cm = [1 0 0; 0.5 0 0.5; 0 0 1];% Basic Colormap
    cmi = interp1([-2; -1; 0; 1; 5], cm, (-2:5)); 

    % Display the grating
    imshow(grating, 'InitialMagnification', 'fit');
    if colour == 0
        colormap gray;
    else
        colormap (redblue);
    end
    axis off;
end

% Calculate contrast

%contrast = (max(grating(:)) - min(grating(:))) / (max(grating(:)) + min(grating(:)));

