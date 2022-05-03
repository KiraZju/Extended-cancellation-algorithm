function [output]=  ECA_B_GPU(sig_Ref,sig_clutter_sum,N,M,R,batch)
%% suggestion:batch = [10,100,1000];  
batchSize = N/batch;
S_eca_b_GPU = zeros(batchSize,batch,'gpuArray');
sig_Ref_b_gpu = gpuArray(sig_Ref);
sig_clutter_sum_b_gpu = gpuArray(sig_clutter_sum);
tic
for i = 1:batch
    S_eca_b_GPU(:,i)= ECA(sig_Ref_b_gpu((i-1)*batchSize+1:i*batchSize+R),sig_clutter_sum_b_gpu((i-1)*batchSize+1:i*batchSize),...
    batchSize,M,R);
%     S_eca_b(:,i)= ECA(sig_Ref_b_gpu,sig_clutter_sum_b_gpu,batchSize,M,R);
end
fprintf('GPU processing time is \n')
toc
S_eca_b = gather(S_eca_b_GPU);
output = S_eca_b(:);

end