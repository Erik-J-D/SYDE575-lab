FN = 'cameraman.tiff';

i = imread(FN);
imshow(i);
imfinfo(FN)

%figure;
%imhist(i);

%figure;
%j = histeq(i);
%imshow(j);

%figure;
%imhist(j);

h = fspecial('average')
k = filter2(h,i) ./ 255;

imshow(k);

l = (double(i) ./ 255) - k;
imshow(l + 0.5);