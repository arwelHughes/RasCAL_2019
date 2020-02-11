load bilayermap.mat

grid = ww.grid;

%Note - when integrating over dimensions, will always go in the
%order params/backs/scales/shifts/nbairs/nbsubs/resols
%choose = [1 1];
mask = zeros(numberOfDims,1);
mask(choose) = 1;
for i = 1:length(mask)
    if mask(i) == 0
        grid = trapz(grid,i);
    end
end

grid = squeeze(grid);

figure(1); 
contour(grid,'k-');