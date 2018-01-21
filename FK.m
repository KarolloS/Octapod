function [Q1, Q2, Q3]  = FK(fi)

global leg_length_0 leg_length_1 leg_length_2;
a = leg_length_0;
b = leg_length_1;
c = leg_length_2;

% zamiana znaku k¹tów gamma i alpha poniewa¿ rozpatrujemy oœ Y skierowan¹ "za kartkê"
fi(2) = -fi(2);
fi(3) = -fi(3);


Q1 = [ cos(fi(1))*(a + cos(fi(2))*(b + c*cos(fi(3))) - c*sin(fi(2))*sin(fi(3)));
      sin(fi(1))*(a + cos(fi(2))*(b + c*cos(fi(3))) - c*sin(fi(2))*sin(fi(3)));
      - sin(fi(2))*(b + c*cos(fi(3))) - c*cos(fi(2))*sin(fi(3)) ];

Q2 = [ cos(fi(1))*(a + b*cos(fi(2)));
       sin(fi(1))*(a + b*cos(fi(2)));
       -b*sin(fi(2)) ];
   
Q3 = [ a*cos(fi(1));
       a*sin(fi(1));
       0 ];
   
end
