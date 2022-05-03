M  = 1000; % output number of rows
K = 2000; % matrix multiply inner dimension
N = 100; % output number of coloumns
P = 200; %number of pages
A = rand(M, K, 'gpuArray');
B = rand(K, N, P,'gpuArray');
gd = gpuDevice();
tic;
% perform matrix multiplication of A and B on every page of B without 
% using pagefun
for i = 1:P
    D(:, :, i) = A * B(:,:,i);
end
wait(gd)
toc
gd = gpuDevice();
tic;
% perform matrix multiplication of A and B on every page of B with 
% using pagefun
D = pagefun(@mtimes,A, B);
wait(gd);
toc