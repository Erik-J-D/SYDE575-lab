lena = double(rgb2gray(imread('lena.tiff')));
imshow(lena / 255.)

for i = [1 3 5 10]

    Z = [16   11   10   16   24   40   51   61;
         12   12   14   19   26   58   60   55;
        14   13   16   24   40   57   69   56;
         14   17   22   29   51   87   80   62;
         18   22   37   56   68   109  103  77;
         24   35   55   64   81   104  113  92;
         49   64   78   87   103  121  120  101;
         72   92   95   98   112  100  103  99];

    Z = i * Z;

    T = dctmtx(8);

    F_trans_unquantized = floor(blockproc(lena-128, [8 8], @(x) T*x.data*T'));

    F_trans = round(blockproc(F_trans_unquantized, [8 8], @(x) x.data ./ Z));
    F_trans = floor(blockproc(F_trans, [8 8], @(x) x.data .* Z));
    
    lena_reconstructed = (floor(blockproc(F_trans, [8 8], @(x) T'*x.data*T)) + 127) ./ 255. ;

    figure;
    imshow(lena_reconstructed);

    disp(['PSNR of i = ', num2str(i), ': ', num2str(PSNR(lena ./ 255., lena_reconstructed))])
end