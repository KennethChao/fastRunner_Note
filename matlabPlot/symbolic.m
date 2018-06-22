syms a K T C

A = [1-a^2*K T-a^2*C; 
    -2*a*K 1-a^2*C];

detA = simplify(det(A));

pretty(detA)

trA = simplify(trace(A));



c2 = simplify(1-trA+detA);

pretty(c2)

c3 = simplify(1+trA+detA);

pretty(c3)