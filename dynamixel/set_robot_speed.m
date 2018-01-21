function set_robot_speed(s)

for i=1:24
    set_speed(i,s);
end

fprintf('Speed set to %d\n', s);

end
