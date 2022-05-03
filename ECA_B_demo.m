clear;
clc;
close all
% load('qpsk_source.mat')
load('qpsk_gen_bd_pskmod_2.mat')
qpsk_source = txSig_r;
% load('qpsk_gen_bd_pskmod.mat')

N = 200000;
G = pow2db(N);
R = 500;
M = 250;
%% clutter
K = 4;
sigRef = qpsk_source(1:N+R);
% delay_clutter = randperm(N/10,K);
delay_clutter_t = randperm(M,K);
delay_clutter = [sort(delay_clutter_t),300,1];
for ii = 1:K+2
    sig_clutter(:,ii) =  [qpsk_source(R+1-delay_clutter(ii):R);qpsk_source(R+1:R+N-delay_clutter(ii))];
end
sig_clutter_sum = sum(sig_clutter,2);
SNR = -10;
sig_clutter_sum = awgn(sig_clutter_sum,SNR,'measured');

sig_clutter_sum_2 = [sig_clutter_sum;zeros(length(sigRef)-length(sig_clutter_sum),1)];

[xr_2,index] = fast_xcorr_FFT(sig_clutter_sum_2,sigRef);
figure
plot(index+R,abs(xr_2))
axis([-50 600 0 1.2*max(abs(xr_2))])

tic
fprintf('ECA processing time for N = %d is \n',N)

cur_mat = zeros(N,M);
%%
for jj = 1:M
    cur_mat(:,jj) = [sigRef(R-jj+1:R+N-jj)];
end
S_r = cur_mat;
a_ver = pinv(S_r'*S_r)*S_r'*sig_clutter_sum;
S_eca = sig_clutter_sum-S_r*a_ver;
toc
%%
S_eca_ex = [S_eca(:);zeros(length(sigRef)-length(S_eca),1)];
% figure
[xr_3] = fast_xcorr_FFT(S_eca_ex,sigRef);

fprintf('ECA-B processing time for N = %d is \n',N)

tic
batch =10;
S_eca_fun = ECA_B(sigRef,sig_clutter_sum,N,M,R,batch);
toc
S_eca_fun_ex = [S_eca_fun(:);zeros(length(sigRef)-length(S_eca),1)];
[xr_4] = fast_xcorr_FFT(S_eca_fun_ex,sigRef);
hold on
plot(index+R,abs(xr_3))
plot(index+R,abs(xr_4))
legend('Before ECA','After ECA','After ECA-B')
xlabel('Range bin')
ylabel('Magnitude')
set(gcf,'color','white')
grid on
