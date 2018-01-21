function [] = myline_update(h, P1, P2 )

pts = [P1; P2];
set(h, 'xdata', pts(:,1), 'ydata', pts(:,2), 'zdata', pts(:,3))
hold on

end

