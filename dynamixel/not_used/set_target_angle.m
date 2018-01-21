function set_target_angle(id,g)

% Control table address
ADDR_AX_GOAL_POSITION       = 30;

% Protocol version
PROTOCOL_VERSION            = 1.0;
global port_num;

COMM_SUCCESS                = 0;
HARDWARE_OK                 = 0;

target_pos = g/0.29 + 512;

% Write goal position
write2ByteTxOnly(port_num, PROTOCOL_VERSION, id, ADDR_AX_GOAL_POSITION, target_pos);

if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
    disp('Comunication error!');
elseif getLastRxPacketError(port_num, PROTOCOL_VERSION) ~= HARDWARE_OK
    disp('Hardware error:');
    hardware_status();
end

end