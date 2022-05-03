clear;
clc;
N = 2000;
R = 1000;
B = zeros(N,N+R-1);
for i = 1:N
    for j = 1:N+R-1
        if i==j-R+1
            B(i,j) = 1;
        end
    end
end
D = zeros(N+R-1,N+R-1);
for i = 1:N+R-1
    for j = 1:N+R-1
        if i==j+1
            D(i,j) = 1;
        end
    end
end
D0 = eye(N+R-1,N+R-1);
D2 = D*D;
D3 = D*D*D;

p = 1;
pvect = [0:p]
vect = (1:N+R-1);
v = 1./vect
delta = exp(1j*2*pi*p*v)
delta1 = diag(delta);