function robot_start_not_working( )

global leg_length_0 leg_length_1 leg_length_2;
a = 11;

% d³ugoœæ kolejnych nóg
% kolejnoœæ R1 R2 R3 R4 L1 L2 L3 L4
leg_l(1,:) = [6 20 40];
leg_l(2,:) = [6 20 40];
leg_l(3,:) = [6 20 35];
leg_l(4,:) = [6 20 35];
leg_l(5,:) = [6 20 40];
leg_l(6,:) = [6 20 40];
leg_l(7,:) = [6 20 35];
leg_l(8,:) = [6 20 35];

set = zeros(3,8);
fi_tab = zeros(185,3,8); %kolejnoœæ teta, gamma, alpha

vect(1,:) = [10.75, 11.5];
vect(2,:) = [12, 3];
vect(3,:) = [12, -4.5];
vect(4,:) = [10.25, -11.5];
vect(5,:) = [-10.75, 11.5];
vect(6,:) = [-12, 3];
vect(7,:) = [-12, -4.5];
vect(8,:) = [-10.25, -11.5];

for k=1:8
    set(1:2,k) = 1.9*vect(k,:)';
    set(3,k) = -25;
end

%kinematyka odwrotna
for k=1:8
    leg_length_0 = leg_l(k,1);
    leg_length_1 = leg_l(k,2);
    leg_length_2 = leg_l(k,3);

    [state, fi(:)] = IK(set(:,k));
    fi_tab(a,:,k) = fi(:)';
    
    if(state==1)
        disp(['B³¹d IK  noga: ' num2str(k) '  t: ' num2str(t)]);
        break;
    end
end

set_robot_torque(1);
set_robot_speed(128);

% wykonanie ruchu napêdami
set_robot_angle_sync(fi_tab(a,:,:));

end

