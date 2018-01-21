function robot_stop()
global port_num;
global group_num;

% Data Byte Length
LEN_AX_GOAL_POSITION        = 2;

% Protocol version
PROTOCOL_VERSION            = 1.0;

% Default setting
COMM_SUCCESS                = 0;
HARDWARE_OK                 = 0;

set_robot_speed(48);

dxl_addparam_result = groupSyncWriteAddParam(group_num, 2, 428, LEN_AX_GOAL_POSITION);
if dxl_addparam_result ~= true
    fprintf('groupSyncWrite addparam failed (servo id: %d)', 2);
    return;
end

for i=[5, 8, 11]
    dxl_addparam_result = groupSyncWriteAddParam(group_num, i, 458, LEN_AX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('groupSyncWrite addparam failed (servo id: %d)', i);
        return;
    end
end

dxl_addparam_result = groupSyncWriteAddParam(group_num, 14, 596, LEN_AX_GOAL_POSITION);
if dxl_addparam_result ~= true
    fprintf('groupSyncWrite addparam failed (servo id: %d)', 14);
    return;
end

for i=[17, 20, 23]
    dxl_addparam_result = groupSyncWriteAddParam(group_num, i, 566, LEN_AX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('groupSyncWrite addparam failed (servo id: %d)', i);
        return;
    end
end

groupSyncWriteTxPacket(group_num);

if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
    disp('Comunication error!');
elseif getLastRxPacketError(port_num, PROTOCOL_VERSION) ~= HARDWARE_OK
    disp('Hardware error:');
    hardware_status();
end

groupSyncWriteClearParam(group_num);


for i=[3, 6, 9, 12]
    dxl_addparam_result = groupSyncWriteAddParam(group_num, i, 143, LEN_AX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('groupSyncWrite addparam failed (servo id: %d)', i);
        return;
    end
end

for i=[15, 18, 21, 24]
    dxl_addparam_result = groupSyncWriteAddParam(group_num, i, 881, LEN_AX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('groupSyncWrite addparam failed (servo id: %d)', i);
        return;
    end
end

for i=[1, 4, 7, 10, 13, 16, 19, 22]
    dxl_addparam_result = groupSyncWriteAddParam(group_num, i, 512, LEN_AX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('groupSyncWrite addparam failed (servo id: %d)', i);
        return;
    end
end

groupSyncWriteTxPacket(group_num);

if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
    disp('Comunication error!');
elseif getLastRxPacketError(port_num, PROTOCOL_VERSION) ~= HARDWARE_OK
    disp('Hardware error:');
    hardware_status();
end

groupSyncWriteClearParam(group_num);


while 1
    status = 0;
    for i=1:24
        if get_moving_status(i)==1
            status = 1;
            break;
        end
    end
    
    if status==0
        break;
    end
end

set_robot_torque(0)

end

