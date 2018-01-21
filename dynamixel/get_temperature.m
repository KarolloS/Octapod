function get_temperature( )

% Control table address
ADDR_AX_PRESENT_TEMPERATURE    = 43;

% Protocol version
PROTOCOL_VERSION            = 1.0;
global port_num;

COMM_SUCCESS                = 0;
HARDWARE_OK                 = 0;

for i=1:24
    % Read present temperature
    t = read2ByteTxRx(port_num, PROTOCOL_VERSION, i, ADDR_AX_PRESENT_TEMPERATURE);
    
    if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
        disp('Comunication error!');
    elseif getLastRxPacketError(port_num, PROTOCOL_VERSION) ~= HARDWARE_OK
        disp('Hardware error:');
        hardware_status();
    end
    
    fprintf('[ID: %03d] aktualna temperatura: %d stopni Celsjusza\n', i, t);
end


end


