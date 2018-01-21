function leg_move()
global port_num;
global group_num;

% Data Byte Length
LEN_AX_GOAL_POSITION        = 2;

% Protocol version
PROTOCOL_VERSION            = 1.0;

% Default setting
COMM_SUCCESS                = 0;
HARDWARE_OK                 = 0;

set_robot_speed(70);

while(1)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    dxl_addparam_result = groupSyncWriteAddParam(group_num, 1, 620, LEN_AX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('groupSyncWrite addparam failed (servo id: %d)', 2);
        return;
    end

    dxl_addparam_result = groupSyncWriteAddParam(group_num, 2, 489, LEN_AX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('groupSyncWrite addparam failed (servo id: %d)', 2);
        return;
    end

    dxl_addparam_result = groupSyncWriteAddParam(group_num, 3, 376, LEN_AX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('groupSyncWrite addparam failed (servo id: %d)', 2);
        return;
    end
    
    groupSyncWriteTxPacket(group_num);

    if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
        disp('Comunication error!');
    elseif getLastRxPacketError(port_num, PROTOCOL_VERSION) ~= HARDWARE_OK
        disp('Hardware error:');
        hardware_status();
    end

    groupSyncWriteClearParam(group_num);
    
    pause(0.4);

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    dxl_addparam_result = groupSyncWriteAddParam(group_num, 13, 400, LEN_AX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('groupSyncWrite addparam failed (servo id: %d)', 2);
        return;
    end

    dxl_addparam_result = groupSyncWriteAddParam(group_num, 14, 581, LEN_AX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('groupSyncWrite addparam failed (servo id: %d)', 2);
        return;
    end

    dxl_addparam_result = groupSyncWriteAddParam(group_num, 15, 873, LEN_AX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('groupSyncWrite addparam failed (servo id: %d)', 2);
        return;
    end

    groupSyncWriteTxPacket(group_num);

    if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
        disp('Comunication error!');
    elseif getLastRxPacketError(port_num, PROTOCOL_VERSION) ~= HARDWARE_OK
        disp('Hardware error:');
        hardware_status();
    end

    groupSyncWriteClearParam(group_num);
    
    pause(1);

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
%     dxl_addparam_result = groupSyncWriteAddParam(group_num, 1, 561, LEN_AX_GOAL_POSITION);
%     if dxl_addparam_result ~= true
%         fprintf('groupSyncWrite addparam failed (servo id: %d)', 2);
%         return;
%     end

    dxl_addparam_result = groupSyncWriteAddParam(group_num, 2, 427, LEN_AX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('groupSyncWrite addparam failed (servo id: %d)', 2);
        return;
    end

    dxl_addparam_result = groupSyncWriteAddParam(group_num, 3, 132, LEN_AX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('groupSyncWrite addparam failed (servo id: %d)', 2);
        return;
    end
    
    groupSyncWriteTxPacket(group_num);

    if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
        disp('Comunication error!');
    elseif getLastRxPacketError(port_num, PROTOCOL_VERSION) ~= HARDWARE_OK
        disp('Hardware error:');
        hardware_status();
    end

    groupSyncWriteClearParam(group_num);
    
    pause(0.4);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
%     dxl_addparam_result = groupSyncWriteAddParam(group_num, 13, 389, LEN_AX_GOAL_POSITION);
%     if dxl_addparam_result ~= true
%         fprintf('groupSyncWrite addparam failed (servo id: %d)', 2);
%         return;
%     end
    
    dxl_addparam_result = groupSyncWriteAddParam(group_num, 14, 549, LEN_AX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('groupSyncWrite addparam failed (servo id: %d)', 2);
        return;
    end

    dxl_addparam_result = groupSyncWriteAddParam(group_num, 15, 645, LEN_AX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('groupSyncWrite addparam failed (servo id: %d)', 2);
        return;
    end
       
    groupSyncWriteTxPacket(group_num);

    if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
        disp('Comunication error!');
    elseif getLastRxPacketError(port_num, PROTOCOL_VERSION) ~= HARDWARE_OK
        disp('Hardware error:');
        hardware_status();
    end
    
    groupSyncWriteClearParam(group_num);
    
    pause(1);


end

end

