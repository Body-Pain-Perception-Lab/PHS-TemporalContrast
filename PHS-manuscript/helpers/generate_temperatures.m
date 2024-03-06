%% Function for creating temperatures to match required contrast
% c = desired contrast
% t1 = one fixed temperature
% tq = the quality of the fixed temperature (cold = 0 or warm = 1)
% max = maximum temperature to calculate contrast from (usually 50)
% base = baseline temperature 
function temps = generate_temperatures(c, t1, max, base)
    if t1 < base
        % calculate contrast for warm temperature
        t2 = (c * max) + t1;
        tw = t2;
        tc = t1;
    else
        % calculate contrast for cold temperature
        t2 = t1 - (c * max);
        tw = t1;
        tc = t2;
    end

    % create temperature data-frame
    temps = [tw:-1:tc, tc:1:tw];
    temps = [base:1:tw, repmat(temps, 1, 2), tw:-1:tc, tc:1:base];
end