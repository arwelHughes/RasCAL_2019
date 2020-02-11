close all

axs3(1) = scrollsubplot(3,3,1);
  axs3(2) = scrollsubplot(3,3,2);
  axs3(3) = scrollsubplot(3,3,3);
  axs3(4) = scrollsubplot(3,3,4);
  axs3(5) = scrollsubplot(3,3,5);
  axs3(6) = scrollsubplot(3,3,6);
  axs3(7) = scrollsubplot(3,3,7);
  axs3(8) = scrollsubplot(3,3,20);
  for i1 = 1:8,
    if ishandle(axs3(i1))
      axes(axs3(i1))
      imagesc(randn(2+3*i1))
    end
  end
