function [state, fi ] = IK(setv)
% Oblicza konemeatykê ogwrotn¹

global leg_length_0 leg_length_1 leg_length_2;
a = leg_length_0;
b = leg_length_1;
c = leg_length_2;


teta = atan2(setv(2),setv(1));

p = sqrt(setv(1)^2 + setv(2)^2);

cosa = ((p-a)^2 + setv(3)^2 - b^2 - c^2)/(2*b*c);

if cosa>1 || cosa<-1
    disp('poza przestrzeni¹ robocz¹');
    state = 1;
    fi(1) = 0;
    fi(2) = 0;
    fi(3) = 0;
    return;
end

sina1 = sqrt(1 - cosa^2);
sina2 = -sqrt(1 - cosa^2);

alpha1 = atan2(sina1,cosa);
alpha2 = atan2(sina2,cosa);

% chcemy aby alpha by³ z zakresu [-pi 0]
if alpha1 > -pi && alpha1 < 0
    alpha = alpha1;
else
    alpha = alpha2;
end

detg = b^2 + c^2 + 2*b*c*cosa;
sing = (setv(3)*(b+c*cos(alpha))-(p-a)*c*sin(alpha))/detg;
cosg = ((p-a)*(b+c*cos(alpha))+setv(3)*c*sin(alpha))/detg;

gamma = atan2(sing,cosg);

state = 0;

% zmiana znaku aby by³a zgodnoœæ z globalnym uk³adem odniesienia
% gamma = -gamma;
% alpha = -alpha;


fi(1) = teta;
fi(2) = gamma;
fi(3) = alpha;
end

