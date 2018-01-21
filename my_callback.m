function my_callback(~,~)

global set_x  set_y;
global global_stop;
global distance_min;


a = get(gcbf, 'SelectionType');
if strcmp(a,'normal')
    disp('Nowy cel');
    
    [set] = get(gca,'CurrentPoint');
%     set_x = set(1,1);
%     set_y = set(1,2);
    set_x = set(1,1)/7;
    set_y = set(1,2)/7;
    
    title(['CEL:    x= ' num2str(set_x) '   y=' num2str(set_y)]);
    distance_min = 99999999;
    
elseif strcmp(a,'alt')
    disp('STOP');
    global_stop = 1;
end

end

