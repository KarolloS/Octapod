function set_robot_torque(a)

for i=1:24
    set_torque(i,a);
end

if a==1
    disp('Torque enabled');
else
    disp('Torque disabled');
end

end

