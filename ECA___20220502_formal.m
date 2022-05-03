clear;
clc;
load('qpsk_source.mat')

N = 2000;
R = 1000;
delay1 = 200;
sigRef = qpsk_source(1:N+R);

sigSurv =  qpsk_source(delay1+1:delay1+N);
[xr,index] = xcorr(sigRef,sigSurv);
plot(index,abs(xr))
axis([-50 400 0 1.2*max(abs(xr))])
% B = zeros(N,N+R-1);
% for i = 1:N
%     for j = 1:N+R-1
%         if i==j-R+1
%             B(i,j) = 1;
%         end
%     end
% end
B = [zeros(N,R) eye(N)];
% D = zeros(N+R,N+R);
K = 200;  
% for i = 1:N+R
%     for j = 1:N+R
%         if i==j+1
%             D(i,j) = 1;
%         end
%     end
% end
% D0 = eye(N+R-1,N+R-1);
% D2 = D^2;
% D3 = D*D*D;

Sref = zeros(N+R,K);
Sref(:,1) = [sigRef'];
for i = 2:K
    temp = [zeros(1,i-1) sigRef(1:N+R-i+1)];
    Sref(:,i) = temp';
    fprintf('%d\n',i)
end

%%
p = 10;
% vect = (1:N+R-1);
% v = 1./vect
% delta = [1 exp(1j*2*pi*p*v)]
% delta1 = diag(delta);
result = zeros(N+R,p*K);
for i = 1:p
    
    vect = (1:N+R-1);
    v = 1./vect;
    delta = [1 exp(1j*2*pi*i*v)];
    delta1 = diag(delta);
    temp = delta1*Sref;
    result(:,i:i+K-1) = temp;
    
end
result1 = fliplr(conj(result));
basis = [result1 Sref result];
H = B*basis;
weightP = pinv(H'*H)*H'*sigSurv';
weight = zeros((2*p+1)*K,1);