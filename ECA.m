function [S_eca] = ECA(sig_Ref,sig_clutter_sum,N,M,R)
%% 
% ECA
%% reference:
% [1] A Multistage Processing Algorithm for Disturbance Removal and Target Detection in Passive Bistatic Radar
% [2] Disturbance removal in passive radar via sliding extensive cancellation algorithm (ECA-S)
% sig_Ref:reference signal
% sig_cluter_sum:surveillance signal
% N:signal length Used
% M:max_lag for cancellation
% R: max_lag
S_r = zeros(N,M);
%%
for jj = 1:M
    S_r(:,jj) = [sig_Ref(R-jj+1:R+N-jj)];
end
a_ver = pinv(S_r'*S_r)*S_r'*sig_clutter_sum;
S_eca = sig_clutter_sum-S_r*a_ver;

end