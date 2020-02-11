function [x_new_tot,y_new_tot] = resample_sld(sld,y_min_step)

x = sld(:,1);
prof = sld(:,2);

% x_new = zeros(1e4,1);
% y_new = zeros(1e4,1);

thisx = x(1);
count = 1;
i = 2;
while i < length(x)
    this_step = prof(i) - prof(i-1);
    if abs(this_step) < y_min_step
        %Keep original points
        x_new(count) = x(i);
        y_new(count) = prof(i);
        count = count + 1;
        i = i + 1;
    else
        if this_step > 0
            newsteps = prof(i-1):y_min_step:prof(i);
        else
            newsteps = prof(i-1):-y_min_step:prof(i);
        end
        new_xs = interp1(prof(i-1:i),x(i-1:i),newsteps);
        x_new = [x_new(:); new_xs(:)];
        y_new = [y_new(:); newsteps(:)];
        count = length(x_new);
        i = i + 1;
    end
end
x_new_tot = x_new(:);
y_new_tot = y_new(:);

% x_new = x_new(1:count,1);
% y_new = y_new(1:count,1);

%Make it into a 'histogram'
x_new_tot = zeros(count,1);
y_new_tot = zeros(count,1);
for i =1:length(x_new)-1;
    x_new_tot(i) = x_new(i + 1) - x_new(i);
    y_new_tot(i) = y_new(i);
end

%Remove any zero thickness layers...
good_layers = find(x_new_tot ~= 0);
x_new_tot = x_new_tot(good_layers);
y_new_tot = y_new_tot(good_layers);


