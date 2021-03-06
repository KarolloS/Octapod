function p = get_position(id)

% Control table address
ADDR_AX_PRESENT_POSITION    = 36;

% Protocol version
PROTOCOL_VERSION            = 1.0;
global port_num;

COMM_SUCCESS                = 0;
HARDWARE_OK                 = 0;

% Read present position
p = read2ByteTxRx(port_num, PROTOCOL_VERSION, id, ADDR_AX_PRESENT_POSITION);

if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
    disp('Comunication error!');
elseif getLastRxPacketError(port_num, PROTOCOL_VERSION) ~= HARDWARE_OK
    disp('Hardware error:');
    hardware_status();
end

% p = (p-512)*0.29;

end


