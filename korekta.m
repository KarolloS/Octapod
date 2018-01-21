function set = korekta(t,set)


% noga R2
p = 96;
q = -3;
r=12;
if t>(p-r) && t<(p+r)
    set(2,2) = set(2,2) - (q/(r^2))*(t^2-2*p*t+(p^2-r^2));
end

% noga R3
p = 52;
q = -8;
r=32;
if t>(p-r) && t<(p+r)
    set(2,3) = set(2,3) - (q/(r^2))*(t^2-2*p*t+(p^2-r^2));
end

% noga L1
p = 26;
q = 4;
r=14;
if t>(p-r) && t<(p+r)
    set(2,5) = set(2,5) - (q/(r^2))*(t^2-2*p*t+(p^2-r^2));
end

p = 26;
q = 2;
r=14;
if t>(p-r) && t<(p+r)
    set(1,5) = set(1,5) - (q/(r^2))*(t^2-2*p*t+(p^2-r^2));
end

% noga L2
p = 26;
q = -8;
r=14;
if t>(p-r) && t<(p+r)
    set(2,6) = set(2,6) - (q/(r^2))*(t^2-2*p*t+(p^2-r^2));
end

% noga L3
p = 124;
q = -8;
r=14;
if t>(p-r) && t<(p+r)
    set(2,7) = set(2,7) - (q/(r^2))*(t^2-2*p*t+(p^2-r^2));
end

end