syms s1 c1 c2 s2 c3 s3 c4 s4 c5 s5 c6 s6 
syms a2 a3
syms d6 d2 d3

z0 = [0; 0; 1];
z1 = [-s1; c1; 0];
z2 = [c1*s2; s1*s2; c2];
z3 = z2;
z4 = [-c1*c2*s4-s1*c4; -s1*c2*s4+c1*c4; s2*s4];
z5 = [c1*c2*c4*s5+c1*c5*s2-s1*s4*s5; c1*s4*s5+c2*c4*s1*s5+c5*s1*s2; c2*c5-c4*s2*s5]

o0 = [0; 0; 0;];
o1 = o0;
o2 = [-s1*d2; c1*d2; 0;];
o3 =  [c1*s2*d3-s1*d2; s1*s2*d3+c1*d2; c2*d3];
o4 = o3;
o5 = o4;
o6= [c1*s2*d3-s1*d2+d6*(c1*c2*c4*s5+c1*c5*s2-s1*s4*s5); ...
    s1*s2*d3+c1*d2+d6*(c1*s4*s5+c2*c4*s1*s5+c5*s1*s2);...
    c2*d3+d6*(c2*c5-c4*s2*s5)]

J1 = [cross(z0,(o6-o0)); z0];
J2 = [cross(z1,(o6-o1)); z1];
J3 = [z2; 0];
J4 = [cross(z3,(o6-o3)); z3];
J5 = [cross(z4,(o6-o4)); z4];
res = o6 - o5
J6 = [cross(z5,(o6-o5)); z5]

