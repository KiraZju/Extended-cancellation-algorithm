说明文档：（2022年05月03日）
一、程序列表：
1）ECA___20220502_formal：旧的ECA程序
2）ECA：ECA
3）ECA_B：ECA-batch version
4）ECA_B_GPU：ECA-batch version on GPU

二、demo程序
1）ECA_demo：only ECA
2）ECA_B_demo：N<=200000，比较ECA和ECA-B
3）ECA_B_demo_2：N=2000000，比较ECA和ECA-B，只能ECA-B可以运行（ECA内存<10GB，显示内存不足）

三、其他子程序：
1）fast_xcorr_FFT：基于FFT的快速互相关
2）BB：？？？
3）GPU_demo:from(https://www.csdn.net/tags/OtTaAg3sOTgwMDgtYmxvZwO0O0OO0O0O.html)

数据：
1）qpsk_source：实信号，中频信号
2）qpsk_gen_bd_pskmod：复数信号，QPSK
3）qpsk_gen_bd_pskmod_2：复数信号，QPSK+升余弦滤波

结论：ECA和ECA-B可以实现，我发现基于GPU加速的matlab程序暂时无法带来加速性能提升，反而运行时间更长！！

future work：ECA-S？？？？

参考文献：
[1] A Multistage Processing Algorithm for Disturbance Removal and Target Detection in Passive Bistatic Radar
[2] Disturbance removal in passive radar via sliding extensive cancellation algorithm (ECA-S)
[3] Sliding extensive cancellation algorithm for disturbance removal in passive radar
