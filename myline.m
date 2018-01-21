function [h] = myline( P1, P2 )

pts = [P1; P2];
h = plot3(pts(:,1), pts(:,2), pts(:,3),'b','LineWidth',1.5);
hold on

end

