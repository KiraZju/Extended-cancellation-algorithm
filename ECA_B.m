function [output]=  ECA_B(sig_Ref,sig_clutter_sum,N,M,R,batch)
%% suggestion:batch = [10,100,1000];  
batchSize = N/batch;
S_eca_b = zeros(batchSize,batch);
for i = 1:batch
    sig_Ref_b = sig_Ref((i-1)*batchSize+1:i*batchSize+R);  % (N+R)x1

    sig_clutter_sum_b = sig_clutter_sum((i-1)*batchSize+1:i*batchSize);  % Nx1
    S_eca_b(:,i)= ECA(sig_Ref_b,sig_clutter_sum_b,batchSize,M,R);
end
output = S_eca_b(:);

end