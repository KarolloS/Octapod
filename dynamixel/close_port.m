function close_port()

lib_name = 'dxl_x64_c';
global port_num;

% Close port
closePort(port_num);
disp('Succeeded to close the port');

% Unload Library
unloadlibrary(lib_name);

close all;
end

