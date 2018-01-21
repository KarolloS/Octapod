function open_port()

clear;clc;

% Load Libraries
lib_name = 'dxl_x64_c';
if ~libisloaded(lib_name)
    [~, ~] = loadlibrary(lib_name, 'dynamixel_sdk.h', 'addheader', 'port_handler.h', 'addheader', 'packet_handler.h', 'addheader', 'group_sync_write.h');
end

% Control table address
ADDR_AX_GOAL_POSITION       = 30;

% Data Byte Length
LEN_AX_GOAL_POSITION        = 2;

% Protocol version
PROTOCOL_VERSION            = 1.0;

% Default setting
BAUDRATE                    = 1000000;       
DEVICENAME                  = 'COM3';

% Initialize PortHandler Structs
global port_num;
port_num = portHandler(DEVICENAME);

% Initialize PacketHandler Structs
packetHandler();

% Initialize Groupsyncwrite instance
global group_num;
group_num = groupSyncWrite(port_num, PROTOCOL_VERSION, ADDR_AX_GOAL_POSITION, LEN_AX_GOAL_POSITION);

% Open port
if (openPort(port_num))
    disp('Succeeded to open the port');
else
    unloadlibrary(lib_name);
    disp('Failed to open the port');
    disp('(sprawdü numer portu COM)');
    return;
end


% Set port baudrate
if (setBaudRate(port_num, BAUDRATE))
    disp('Succeeded to change the baudrate');
else
    unloadlibrary(lib_name);
    disp('Failed to change the baudrate');
    return;
end

end

