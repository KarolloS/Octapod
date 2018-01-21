function set_robot(fi_tab)

teta_tab(1) = atan2(11.5,10.75);
teta_tab(2) = atan2(3,12.3);
teta_tab(3) = atan2(-4.5,12);
teta_tab(4) = atan2(-11.5,10.25);
teta_tab(5) = atan2(11.5,-10.75);
teta_tab(6) = atan2(3,-12.3);
teta_tab(7) = atan2(-4.5,-12);
teta_tab(8) = atan2(-11.5,-10.25);


%ALPHA
fi_tab(1,3,1) = fi_tab(1,3,1) + deg2rad(34);
fi_tab(1,3,2) = fi_tab(1,3,2) + deg2rad(34);
fi_tab(1,3,3) = fi_tab(1,3,3) + deg2rad(34);
fi_tab(1,3,4) = fi_tab(1,3,4) + deg2rad(34);
fi_tab(1,3,5) = - (fi_tab(1,3,5) + deg2rad(34));
fi_tab(1,3,6) = - (fi_tab(1,3,6) + deg2rad(34));
fi_tab(1,3,7) = - (fi_tab(1,3,7) + deg2rad(34));
fi_tab(1,3,8) = - (fi_tab(1,3,8) + deg2rad(34));

%GAMMA
fi_tab(1,2,1) = - (fi_tab(1,2,1) - pi/2);
fi_tab(1,2,2) = - (fi_tab(1,2,2) - pi/2);
fi_tab(1,2,3) = - (fi_tab(1,2,3) - pi/2);
fi_tab(1,2,4) = - (fi_tab(1,2,4) - pi/2);
fi_tab(1,2,5) = (fi_tab(1,2,5) - pi/2);
fi_tab(1,2,6) = (fi_tab(1,2,6) - pi/2);
fi_tab(1,2,7) = (fi_tab(1,2,7) - pi/2);
fi_tab(1,2,8) = (fi_tab(1,2,8) - pi/2);

%TETA
fi_tab(1,1,1) = fi_tab(1,1,1) - teta_tab(1);
fi_tab(1,1,2) = fi_tab(1,1,2) - teta_tab(2);
fi_tab(1,1,3) = fi_tab(1,1,3) - teta_tab(3);
fi_tab(1,1,4) = fi_tab(1,1,4) - teta_tab(4);
fi_tab(1,1,5) = fi_tab(1,1,5) - teta_tab(5);
if fi_tab(1,1,6) > 0
    fi_tab(1,1,6) = fi_tab(1,1,6) - teta_tab(6);
else
    fi_tab(1,1,6) = fi_tab(1,1,6) + (2*pi - teta_tab(6));
end
if fi_tab(1,1,7) < 0
    fi_tab(1,1,7) = fi_tab(1,1,7) - teta_tab(7);
else
    fi_tab(1,1,7) = fi_tab(1,1,7) - (2*pi + teta_tab(7));
end
fi_tab(1,1,8) = fi_tab(1,1,8) - teta_tab(8);


%ustaw po¿¹dane wartoœci w serwomechanizmach
for i=1:7
    set_target_angle((3+(i-1)*3),rad2deg(fi_tab(1,3,i)));
    set_target_angle((2+(i-1)*3),rad2deg(fi_tab(1,2,i)));
    set_target_angle((1+(i-1)*3),rad2deg(fi_tab(1,1,i)));
end

end

