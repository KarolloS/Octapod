function get_load( )

% Control table address
ADDR_AX_PRESENT_LOAD    = 40;

% Protocol version
PROTOCOL_VERSION            = 1.0;
global port_num;

COMM_SUCCESS                = 0;
HARDWARE_OK                 = 0;

for i=1:24
    % Read present load
    l = read2ByteTxRx(port_num, PROTOCOL_VERSION, i, ADDR_AX_PRESENT_LOAD);
    
    if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
        disp('Comunication error!');
    elseif getLastRxPacketError(port_num, PROTOCOL_VERSION) ~= HARDWARE_OK
        disp('Hardware error:');
        hardware_status();
    end
    
    if l < 1023
        fprintf('[ID: %03d ] aktualne obci¹¿enie: %.2f CCW\n', i, l/1023*100);
    else
        fprintf('[ID: %03d ] aktualne obci¹¿enie: %.2f CW\n', i, (l-1023)/1023*100);
    end
end

end


