function hardware_status()

ERRBIT_VOLTAGE     = 1;
ERRBIT_ANGLE       = 2;
ERRBIT_OVERHEAT    = 4;
ERRBIT_RANGE       = 8;
ERRBIT_CHECKSUM    = 16;
ERRBIT_OVERLOAD    = 32;
ERRBIT_INSTRUCTION = 64;

% Protocol version
PROTOCOL_VERSION            = 1.0;
global port_num;

status = getLastTxRxResult(port_num, PROTOCOL_VERSION);

 if bitand(status, ERRBIT_VOLTAGE)~=0
     disp('Input Voltage Error!');
 end
 if bitand(status,ERRBIT_ANGLE)~=0
     disp('Angle limit error!');
 end
 if bitand(status,ERRBIT_OVERHEAT)~=0
     disp('Overheat error!');
 end
 if bitand(status,ERRBIT_RANGE)~=0
     disp('Out of range error!');
 end
 if bitand(status,ERRBIT_CHECKSUM)~=0
     disp('Checksum error!');
 end
 if bitand(status,ERRBIT_OVERLOAD)~=0
     disp('Overload error!');
 end
 if bitand(status,ERRBIT_INSTRUCTION)~=0
     disp('Instruction code error!');
 end
 
 end

