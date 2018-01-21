function m = get_moving_status(id)

% Control table address
ADDR_AX_MOVING              = 46;

% Protocol version
PROTOCOL_VERSION            = 1.0;
global port_num;

COMM_SUCCESS                = 0;
HARDWARE_OK                 = 0;

m = read1ByteTxRx(port_num, PROTOCOL_VERSION, id, ADDR_AX_MOVING);

if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
    disp('Comunication error!');
elseif getLastRxPacketError(port_num, PROTOCOL_VERSION) ~= HARDWARE_OK
    disp('Hardware error:');
    hardware_status();
end

end

