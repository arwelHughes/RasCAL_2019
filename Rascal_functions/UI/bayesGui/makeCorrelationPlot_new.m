function makeCorrelationPlot_new(h,chain,npars,names,pointsFlag,points)

% Makes the correlations plot from chain on the figure
% given by handle h.
% showing ellipses for the scatterplots. 
% If pointsFlag = 1 then the points are shown with a 
% random number of points chosen according to points.
%
% h             = Figure handle
% chain         = Output from mcmcstat
% npars         = Number of parameters
% pointsFlag    = When = 1, points are added. Otherwise just ellipse.

figure(h); clf; pause(0.5)

p = npars;%size(chain,2);
inds = 1:1:npars;

count = 1;
for j=2:p
  for i=1:j-1
    if p==2
      h=gca;
    else
      h=subplot(p-1,p-1,(j-2)*(p-1)+i);
      %h = scrollSubPlot(p-1,p-1,(j-2)*(p-1)+i);
    end
    % Use only parst of the chain
    thisParX = chain(:,i);
    thisParY = chain(:,j);
    %selectIndex = randi(length(thisParx),points,1);
    
%     plotParX = thisParx(selectIndex);
%     plotParY = thisPary(selectIndex);
    
    %plot(thisParX,thisParY,'.'); hold on
    plotEllipse(h,thisParX,thisParY);
    if j~=p
      set(h,'xtick',[])
    end
    if i~=1
      set(h,'ytick',[])
    end
    if i==1 & nargin>2 & ~isempty(names)
      %ylabel(names{j})
      ylabel(num2str(j));
    end
    if i==j-1 & nargin>2 & ~isempty(names)
      if p==2
        xlabel(num2str(i));
      else
        xlabel(num2str(i))
      end
    end
%     count = count+1;
%     msgBoxTest('update',count/npars);
  end
  drawnow;
end

end


function plotEllipse(ax,par1,par2)

data = [par1 par2];

% Calculate the eigenvectors and eigenvalues
covariance = cov(data);
[eigenvec, eigenval ] = eig(covariance);

% Get the index of the largest eigenvector
[largest_eigenvec_ind_c, r] = find(eigenval == max(max(eigenval)));
largest_eigenvec = eigenvec(:, largest_eigenvec_ind_c);

% Get the largest eigenvalue
largest_eigenval = max(max(eigenval));

% Get the smallest eigenvector and eigenvalue
if(largest_eigenvec_ind_c == 1)
    smallest_eigenval = max(eigenval(:,2));
    smallest_eigenvec = eigenvec(:,2);
else
    smallest_eigenval = max(eigenval(:,1));
    smallest_eigenvec = eigenvec(1,:);
end

% Calculate the angle between the x-axis and the largest eigenvector
angle = atan2(largest_eigenvec(2), largest_eigenvec(1));

% This angle is between -pi and pi.
% Let's shift it such that the angle is between 0 and 2pi
if(angle < 0)
    angle = angle + 2*pi;
end

% Get the coordinates of the data mean
avg = mean(data);

% Get the 95% confidence interval error ellipse
chisquare_val = 2.447;
theta_grid = linspace(0,2*pi);
phi = angle;
X0=avg(1);
Y0=avg(2);
a=chisquare_val*sqrt(largest_eigenval);
b=chisquare_val*sqrt(smallest_eigenval);

% the ellipse in x and y coordinates 
ellipse_x_r  = a*cos( theta_grid );
ellipse_y_r  = b*sin( theta_grid );

%Define a rotation matrix
R = [ cos(phi) sin(phi); -sin(phi) cos(phi) ];

%let's rotate the ellipse to some angle phi
r_ellipse = [ellipse_x_r;ellipse_y_r]' * R;

% Draw the error ellipse
plot(r_ellipse(:,1) + X0,r_ellipse(:,2) + Y0,'-','LineWidth',2.0)

end