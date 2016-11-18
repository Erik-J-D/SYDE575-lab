degraded = im2double(imread('degraded.tif'));
cameraman = im2double(imread('cameraman.tif'));
d_max = max(max(degraded));
d_min = min(min(degraded));

imshow('degraded.tif');
rect = getrect

rect(1) = max(floor(rect(1)), 1); %xmin
rect(2) = max(floor(rect(2)), 1);%ymin
rect(3)= min(ceil(rect(1) + rect(3))); %xmax
rect(4)=min(ceil(rect(2) +rect(4))); %ymax

flat_region=degraded(rect(2):rect(4), rect(1):rect(3),:);
imshow(flat_region);
figure
V = var(var(flat_region));

local_mean = colfilt(degraded, [5, 5], 'sliding', @mean);
local_var = colfilt(degraded, [5,5], 'sliding', @var);

K = (local_var - V)/local_var;

new_image = Lee_Filter(degraded, K, local_mean);
imshow(new_image);
figure

gauss_filter = fspecial('gaussian', 30); 
gauss_image = imfilter(degraded, gauss_filter);
imshow(gauss_image);

PSNR_value = psnr(new_image, cameraman);
PSNR_gauss = psnr(gauss_image, cameraman);
