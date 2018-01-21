clc; clear;
load('analiza_workspace.mat', 'W', 'u', 'p', 'z_avg2', 'gn');
load('leg_start.mat', 'set_2'); % inicjalizacja nóg w po³o¿eniu startowym
% load('leg_initialization_1.mat', 'leg_init'); % inicjalizacja nóg do pozycji nie skorygowanej
load('leg_initialization_2.mat', 'leg_init'); % inicjalizacja nóg do pozycji skorygowanej

% przedzia³ wybrany jako jeden cykl
a = 11;
b = 152;

global leg_length_0 leg_length_1 leg_length_2;
fi_tab = zeros(185,3,8); %kolejnoœæ teta, gamma, alpha
leg = zeros(185,3,8,4); % chwila czasowa; x,y,z; R1 R2 R3 R4 L1 L2 L3 L4; koniec nogi -1, poprzedni staw 3 - 2, nowy staw  - 3, pol¹czenie z g³owotu³owiem - 4
leg(:,:,:,:) = leg_init(:,:,:,:);
leg_g = zeros(185,3,8,4);
set_start = zeros(3,8);
set_start(:,:) = set_2(:,:);
set_1 = zeros(3,8);
set_2 = zeros(3,8);
fi = [0,0,0]';

robot_pos_global = [0, 0, 0];
robot_pos_global_old = [0, 0, 0];
robot_angle_global = 0; %k¹t wzglêdem osi y (kierunek ruchu) 
leg_pos_global = zeros (8,3);
pos_sum = [0, 0, 0];

temp = [0, 0, 0];
temp_res_2 = zeros (3,8);
count = 0;
cnt = zeros(8);
global_counter = 1;

angle_old = 0;
angle_sum = 0;
single_step_limit = deg2rad(0.25);
one_y_step = 0.251127312012864;
target = [0,0];

global set_x  set_y;
global distance_min;
set_x = 99999999;
set_y = 99999999;
distance_min = 99999999;

global global_stop; % zmienna odpowiedzialna za awaryjny stop pod prawym przyciskiem myszy
global_stop = 0;

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

% odleg³oœæ œrodka robota od pocz¹tku ka¿dej nogi
center_to_leg(1,:) = [10.75, 11.5, -z_avg2];
center_to_leg(2,:) = [12, 3, -z_avg2];
center_to_leg(3,:) = [12, -4.5, -z_avg2];
center_to_leg(4,:) = [10.25, -11.5, -z_avg2];
center_to_leg(5,:) = [-10.75, 11.5, -z_avg2];
center_to_leg(6,:) = [-12, 3, -z_avg2];
center_to_leg(7,:) = [-12, -4.5, -z_avg2];
center_to_leg(8,:) = [-10.25, -11.5, -z_avg2];

center_to_leg_temp(:,:) = center_to_leg(:,:);
center_to_leg_old(:,:) = center_to_leg(:,:);

% korekcja nóg tak, ¿eby wytrzymywa³y napêdy
cnt_tab = [51, 40, 28, 22, 50, 19, 35, 35];
leg_correction = zeros(2,8);
leg_correction(:, 1) = [-6, -6];
leg_correction(:, 2) = [-10, -10];
leg_correction(:, 3) = [-8, -10];
leg_correction(:, 5) = [6, -8];
leg_correction(:, 6) = [-2, -20];
leg_correction(:, 7) = [8, -10];
leg_correction(:, 8) = [0, -6];

% startowa globalna pozycja nóg
for k=1:8
    leg_pos_global(k,:) = robot_pos_global(:) + leg(a,:,k,1)';
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ruch inicjalizacyjny i wybór trybu
s = input('Wybierz prêdkoœæ:  [1] - wolno  [2] - szybko  [3] - bardzo szybko\n(UWAGA - zostanie wykonany ruch inicjalizacyjny)\n', 's');

%kinematyka odwrotna
for k=1:8
    leg_length_0 = leg_l(k,1);
    leg_length_1 = leg_l(k,2);
    leg_length_2 = leg_l(k,3);

    [state, fi(:)] = IK(set_start(:,k));
    fi_tab(a,:,k) = fi(:)';
    
    if(state==1)
        disp('B³¹d IK ');
        break;
    end
end

% wykonanie ruchu napêdami
set_robot_speed(48);
set_robot_angle_sync(fi_tab(a,:,:));
pause(3);

if s=='1'
    c = 1;
    set_robot_speed(90);
elseif s=='2'
    c = 2;
    set_robot_speed(140);
elseif s=='3'
    c = 3;
    set_robot_speed(190);
elseif s=='q'
    c = 4;
    set_robot_speed(240);
else
    return;
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% pocz¹tek animacji
close all;
figure('OuterPosition', [330 32 1600 1050], 'WindowButtonDownFcn',@my_callback);
h = draw (a, [set_x, set_y], robot_pos_global(:), leg(:,:,1,:), leg(:,:,2,:), leg(:,:,3,:), leg(:,:,4,:), leg(:,:,5,:), leg(:,:,6,:), leg(:,:,7,:), leg(:,:,8,:));
view (0, 90);


while(1)
    
    if global_stop ==1
        break;
    end
    
    title('Nowy punkt docelowy - lewy przycisk myszy        Koniec - prawy przycisk myszy ');
    waitforbuttonpress;

    while (1)
        
        if global_stop ==1
            break;
        end

        for t=a:c:b

            if global_stop ==1
                break;
            end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % RUCH Z OBROTAMI (do wyznaczonego celu)

            % proste wyznaczanie trajektorii -> pod¹¿anie za celem
            distance = sqrt((robot_pos_global(1)-set_x)^2 + (robot_pos_global(2)-set_y)^2);
            if distance<distance_min
                distance_min=distance;
            end
            
            if distance < 2
                disp('Cel osi¹gniêty');
                title('Cel osi¹gniêty');
                title('Nowy punkt docelowy - lewy przycisk myszy        Koniec - prawy przycisk myszy ');
                waitforbuttonpress;
            end

            if distance>distance_min+30
                disp('Cel niemo¿liwy do osi¹gniêcia');
                title('Cel niemo¿liwy do osi¹gniêcia');
                title('Nowy punkt docelowy - lewy przycisk myszy        Koniec - prawy przycisk myszy ');
                waitforbuttonpress;
            end           
            
            if distance > 2
                angle = -atan2(set_x - robot_pos_global(1), set_y - robot_pos_global(2));
                angle = angle - robot_angle_global;
                
                if angle-angle_old>single_step_limit
                    angle = angle_old + single_step_limit;
                elseif angle-angle_old<-single_step_limit
                    angle = angle_old - single_step_limit;
                end
                
                if angle>deg2rad(8)
                    angle = deg2rad(8);
                elseif angle<deg2rad(-8)
                    angle = deg2rad(-8);
                end
            end
            
            angle_old = angle;


            % obroty podczas ruchu
            psi = angle; % ile skrêci siê robot przy jednym ca³ym cyklu % zakres +/- 8deg
            ksi = c * psi / (b-a);

            temp(:) = [0, c*one_y_step 0];
            ROT = [cos(robot_angle_global + psi) -sin(robot_angle_global + psi) 0; sin(robot_angle_global + psi) cos(robot_angle_global + psi) 0; 0 0 1];
            temp(:) = ROT * temp(:);
            
            target(1) = target(1) + temp(1);
            target(2) = target(2) + temp(2);

            for k=1:8 
                ROT = [cos(robot_angle_global + ksi) -sin(robot_angle_global + ksi) 0; sin(robot_angle_global + ksi) cos(robot_angle_global + ksi) 0; 0 0 1];
                center_to_leg_temp(k,:) = ROT * center_to_leg(k,:)';
            end
            
            for k=1:8
                set_1(:,k) = W(t,:,k);
            end 
            
            for k=1:8
                temp2(:) = set_1(:,k)' + center_to_leg(k,:);
                ROT = [cos(robot_angle_global + ksi) -sin(robot_angle_global + ksi) 0; sin(robot_angle_global + ksi) cos(robot_angle_global + ksi) 0; 0 0 1];
                temp2(:) = ROT * temp2(:);
                set_1(:,k) = temp2(:) - center_to_leg_old(k,:)';
            end
            
            center_to_leg_old(:,:) = center_to_leg_temp(:,:);
            
                        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           
             % RUCH PO PROSTEJ LUB SKOSIE (bez wyznaczonego celu)
             
%             target(1) = target(1) + c * 0;
%             target(2) = target(2) + c * one_y_step;
%             for k=1:8
%                 set_1(:,k) = W(t,:,k);
%             end  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
            

            % wyrównanie robota tak aby baza zawsze mia³a sta³y rozmiar
            for k=1:8
                if gn(t,k)==0
                    temp_res_1 = leg_pos_global(k,:) - set_1(:,k)' - center_to_leg_temp(k,:);
                    temp_res_1(1) = temp_res_1(1) - target(1);
                    temp_res_1(2) = temp_res_1(2) - target(2);
                    set_2(:,k) = set_1(:,k) + temp_res_1';
                    
                else
                    if gn(t-c,k)==0
                        temp_res_2(:,k) = leg_pos_global(k,:)' - (robot_pos_global(:) + set_1(:,k) + center_to_leg_temp(k,:)');
                        cnt(k) = 10;
                    end

                    if cnt(k)>0
                        set_2(1:2,k) = set_1(1:2,k) + (cnt(k)/10)*temp_res_2(1:2,k);
                        set_2(3,k) = W(t,3,k); 
                        
                        cnt(k) = cnt(k) - c;
                    else
                        vect = (-cnt(k)/(cnt_tab(k)-10))*leg_correction(:,k);
                        set_2(1:2,k) = set_1(1:2,k) + vect;
                        set_2(3,k) = W(t,3,k);

                        cnt(k) = cnt(k) - c;
                    end
                end
            end     

            
            %kinematyka odwrotna
            for k=1:8
                leg_length_0 = leg_l(k,1);
                leg_length_1 = leg_l(k,2);
                leg_length_2 = leg_l(k,3);

                [state, fi(:)] = IK(set_2(:,k));
                fi_tab(t,:,k) = fi(:)';
                
                if(state==1)
                    disp(['B³¹d IK  noga: ' num2str(k) '  t: ' num2str(t)]);
                    break;
                end

                % informacja o k¹tach w napêdach 
                [Q1, Q2, Q3] = FK(fi_tab(t,:,k));
                leg(t,:,k,4) = [0 0 0]';
                leg(t,:,k,3) = Q3';
                leg(t,:,k,2) = Q2';
                leg(t,:,k,1) = Q1';  
            end
            
            if(state==1)
                break;
            end
            
%             % mo¿liwoœæ zapisania startowego po³o¿enia nóg
%             if t==11
%                 for tw=a:b
%                     for k=1:8
%                         for l=1:4
%                             leg_init(tw,:,k,l) = leg(tw,:,k,l) + center_to_leg(k,:);
%                         end
%                     end
%                 end
%             end
                                  
            
            % wykonanie ruchu napêdami
            for k=1:8
                fi_tab(t,1,k) = fi_tab(t,1,k) - robot_angle_global;
                if fi_tab(t,1,k)>pi
                    fi_tab(t,1,k) = 2*pi - fi_tab(t,1,k);
                end
                if fi_tab(t,1,k)<-pi
                    fi_tab(t,1,k) = 2*pi + fi_tab(t,1,k);
                end
            end
            if global_stop ~= 1
                 set_robot_angle_sync(fi_tab(t,:,:));
            end


            % oblicz globalny k¹t robota
            for k=1:4
                for m=5:8
                    if gn(t,k)==0 && gn(t,m)==0
                        vect1 = [0, 20];
                        vect2 = (leg_pos_global(m,1:2) - leg(t,1:2,m,1)) - (leg_pos_global(k,1:2) - leg(t,1:2,k,1));
                        vecta = [vect1, 0];
                        vectb = [vect2, 0];
                        angle1 = atan2(norm(cross(vecta,vectb)),dot(vecta,vectb));
                        

                        vect1 = [0, 20];
                        vect2 = center_to_leg(m,1:2) - center_to_leg(k,1:2);
                        vecta = [vect1, 0];
                        vectb = [vect2, 0];
                        angle2 = atan2(norm(cross(vecta,vectb)),dot(vecta,vectb));
                        
                        angle_sum = angle_sum + (angle1 - angle2);
                        count = count + 1;
                    end                    
                end
            end
            
            robot_angle_global = angle_sum/count;
            angle_sum = 0;
            

            % oblicz globaln¹ pozycjê robota
            count = 0;
            for k=1:8
                if gn(t,k)==0
                    pos_sum = pos_sum + (leg_pos_global(k,:) - leg(t,:,k,1) - center_to_leg_temp(k,:));
                    count = count + 1;
                    

                end
            end
            robot_pos_global_old(:) = robot_pos_global(:);
            robot_pos_global(:) = pos_sum(:)/count;
            pos_sum = [0, 0, 0];
            count = 0;
            
            for k=1:8
                if gn(t,k)==1
                    leg_pos_global(k,:) = robot_pos_global(:) + leg(t,:,k,1)' + center_to_leg_temp(k,:)';
                end
            end
            
            global_counter = global_counter + 1;

            
            % animacja
            for k=1:8
                leg_g(t,:,k,1) = leg_pos_global(k,:);
                leg_g(t,:,k,2) = leg_pos_global(k,:) + (leg(t,:,k,2) - leg(t,:,k,1));
                leg_g(t,:,k,3) = leg_pos_global(k,:) + (leg(t,:,k,3) - leg(t,:,k,1));
                leg_g(t,:,k,4) = leg_pos_global(k,:) - leg(t,:,k,1);
            end
            update(h,t, [set_x, set_y], robot_pos_global(:), robot_pos_global_old(:), leg_g(:,:,1,:), leg_g(:,:,2,:), leg_g(:,:,3,:), leg_g(:,:,4,:), leg_g(:,:,5,:), leg_g(:,:,6,:), leg_g(:,:,7,:), leg_g(:,:,8,:))
            pause(0.00001);
            
        end       
        
        if(state==1)
            state = 0;
            global_stop = 1;
            break;
        end

    end

end

close all;

get_temperature();
robot_stop();

