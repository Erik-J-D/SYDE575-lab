function PSNR = psnr(distImg, origImg)

    origImg = double(origImg);
    distImg = double(distImg);

    [M, N] = size(origImg);
    error = origImg - distImg;
    MSE = sum(sum(error .* error)) / (M * N);
    
    if(MSE > 0)
        PSNR = 20*log10(255*255/MSE);
    else
        PSNR = 99999;
    end
end

