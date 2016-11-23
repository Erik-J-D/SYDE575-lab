lena = double(rgb2gray(imread('lena.tiff')));
imshow(lena / 255.)
T = dctmtx(8);

% Plot DCT rows

% for i = 1:8
%     figure;
%     plot(T(i,:),'DisplayName','T')
% end

F_trans = floor(blockproc(lena-128, [8 8], @(x) T*x.data*T'));


block1 = F_trans(297:304, 81:88)
block2 = F_trans(1:8, 1:8)

mask = [1   1   1   0   0   0   0   0;
        1   1   0   0   0   0   0   0;
        1   0   0   0   0   0   0   0;
        0   0   0   0   0   0   0   0;
        0   0   0   0   0   0   0   0;
        0   0   0   0   0   0   0   0;
        0   0   0   0   0   0   0   0;
        0   0   0   0   0   0   0   0];
F_thresh = blockproc(F_trans, [8 8], @(x) mask.*x.data);

lena_reconstructed = (floor(blockproc(F_thresh, [8 8], @(x) T'*x.data*T)) + 128) ./ 255. ;
figure;
imshow( lena_reconstructed);

PSNR(lena ./ 255., lena_reconstructed)