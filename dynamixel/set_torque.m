function set_torque(id,a)

% Control table address
ADDR_AX_TORQUE_ENABLE       = 24;           

% Protocol version
PROTOCOL_VERSION            = 1.0;
global port_num;

COMM_SUCCESS                = 0;
HARDWARE_OK                 = 0;


% Enable Dynamixel Torque
write1ByteTxRx(port_num, PROTOCOL_VERSION, id, ADDR_AX_TORQUE_ENABLE, a);

if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
    disp('Comunication error!');
elseif getLastRxPacketError(port_num, PROTOCOL_VERSION) ~= HARDWARE_OK
    disp('Hardware error:');
    hardware_status();
end

end

