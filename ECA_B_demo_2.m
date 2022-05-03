clear;
clc;
close all
% load('qpsk_source.mat')
load('qpsk_gen_bd_pskmod_2.mat')
qpsk_source = txSig_r;
% load('qpsk_gen_bd_pskmod.mat')

N = 2000000;
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

fprintf('ECA-B processing time for N = %d is \n',N)

tic
batch = 1000;
S_eca_fun = ECA_B_GPU(sigRef,sig_clutter_sum,N,M,R,batch);
toc
S_eca_fun_ex = [S_eca_fun(:);zeros(length(sigRef)-length(S_eca_fun),1)];
[xr_4] = fast_xcorr_FFT(S_eca_fun_ex,sigRef);
hold on
plot(index+R,abs(xr_4))
legend('Before ECA','After ECA-B')
xlabel('Range bin')
ylabel('Magnitude')
set(gcf,'color','white')
grid on

%% 历时 19.890126 秒。 for N = 2000000 for ECA-B require for batch = 100,2GB内存
%% 历时 31.912306 秒。 for N = 2000000 for ECA-B require for batch = 1000,0.2GB内存
%% GPU如何加速？？
