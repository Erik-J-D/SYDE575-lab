cameraman = im2double(imread('cameraman.tif'));
degraded = imread('degraded.tif');

%Load Image and Normalize
h = fspecial('disk',4);
f = im2double(imread('cameraman.tif'));
f_norm = f - min(min(f));
f_norm = f_norm ./ max(max(f_norm));

%Create disk blur function
h_freq = fft2(h, size(f,1), size(f,2)); % pad h
%Apply to Image
f_blur = real(ifft2(h_freq.*fft2(f)));
%Show image
imshow(f_blur)
blur_PSNR = PSNR(f_blur, cameraman);

%Applying Inverse Filtering
f_blur_inverse = fft2(f_blur) ./ h_freq;
f_blur_restored = real(ifft2(f_blur_inverse));
imshow(f_blur_restored);
restored_psnr = PSNR(f_blur_restored, cameraman);

%Apply Gaussian Noise
f_blur_gauss = imnoise(f_blur, 'Gaussian', 0.002);

%Inverse Filtering of Gaussian Noise
freq_blur_gauss = fft2(f_blur_gauss);
fg_blur_inverse = freq_blur_gauss ./ h_freq;
fg_blur_restored = real(ifft2(fg_blur_inverse));
imshow(fg_blur_restored);
peak_gauss_snr = PSNR(fg_blur_restored, cameraman);

%Apply Wiener Filtering
estimated_nsr = 0.002 / var(cameraman(:))
f_wiener = deconvwnr(f_blur_gauss, h, estimated_nsr);
imshow(f_wiener);
peak_gauss_snr = PSNR(f_wiener, cameraman);
