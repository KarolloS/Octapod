function set_speed(id,s)

% Control table address
ADDR_AX_MOVING_SPEED        = 32;          

% Protocol version
PROTOCOL_VERSION            = 1.0;
global port_num;

COMM_SUCCESS                = 0;
HARDWARE_OK                 = 0;

% Write moving speed
write2ByteTxRx(port_num, PROTOCOL_VERSION, id, ADDR_AX_MOVING_SPEED, s);

if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
    disp('Comunication error!');
elseif getLastRxPacketError(port_num, PROTOCOL_VERSION) ~= HARDWARE_OK
    disp('Hardware error:');
    hardware_status();
end

end

