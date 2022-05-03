function [y_m,index] = fast_xcorr_FFT(surv,ref)
FFT_s = fftshift(fft(surv));
FFT_ref = fftshift(fft(ref));
y_m = ifftshift(ifft((FFT_s).*conj(FFT_ref)));
index = (-length(surv)/2:length(surv)/2-1);
end