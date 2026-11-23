
%% Lab 2: 2D Convolution and FIR Filters
% Blur, Sharpening and Edge Detection

close all;
clear;
clc;

%% Load and prepare image

if exist('peppers.png','file')
    I0 = imread('peppers.png');
else
    I0 = repmat(imread('cameraman.tif'),1,1,3);
end

if size(I0,3) == 3
    I = im2double(rgb2gray(I0));
else
    I = im2double(I0);
end

figure(1);
imshow(I);
title('Original Grayscale Image');

%% 1) Delta Image and Impulse Response

delta = zeros(101,101);
delta(51,51) = 1;

h_avg = ones(3,3)/9;

H_vis = conv2(delta,h_avg,'same');

figure(2);
imagesc(H_vis);
axis image off;
colorbar;
title('Impulse Response of 3x3 Average Filter');

%% 2) Low-Pass Filtering: Box and Gaussian

h_box3 = ones(3,3)/9;
h_box7 = ones(7,7)/49;

sigma = 1.2;

g1d = fspecial('gaussian',[1 7],sigma);
h_gauss = g1d' * g1d;

I_box3 = imfilter(I,h_box3,'replicate');
I_box7 = imfilter(I,h_box7,'replicate');
I_gauss = imfilter(I,h_gauss,'replicate');

figure(3);
montage({I,I_box3,I_box7,I_gauss},'Size',[1 4]);
title('Original | Box 3x3 | Box 7x7 | Gaussian');

%% 3) Unsharp Masking: Image Sharpening

I_blur = imfilter(I,h_gauss,'replicate');

mask = I - I_blur;

gain = 1.0;

I_sharp = max(min(I + gain*mask,1),0);

figure(4);
montage({I,I_blur,mat2gray(mask),I_sharp},'Size',[1 4]);
title('Original | Blur | High-Frequency Mask | Sharpened');

%% 4) Edge Detection: Sobel and Laplacian

h_sobel_x = fspecial('sobel');
h_sobel_y = h_sobel_x';

Gx = imfilter(I,h_sobel_x,'replicate');
Gy = imfilter(I,h_sobel_y,'replicate');

Gmag = hypot(Gx,Gy);

h_lap = fspecial('laplacian',0.2);

I_lap = imfilter(I,h_lap,'replicate');

figure(5);
montage({mat2gray(Gx),mat2gray(Gy), ...
    mat2gray(Gmag),mat2gray(I_lap)},'Size',[1 4]);

title('Sobel Gx | Sobel Gy | Gradient Magnitude | Laplacian');

%% 5) Correlation versus Convolution

C1 = conv2(I,h_box3,'same');

C2 = imfilter(I,h_box3,'conv','same');

diff_val = max(abs(C1(:)-C2(:)));

fprintf('\nCORRELATION AND CONVOLUTION\n');
fprintf('Maximum difference: %g\n',diff_val);

%% 6) Boundary Handling

I_rep = imfilter(I,h_box7,'replicate');
I_sym = imfilter(I,h_box7,'symmetric');
I_cir = imfilter(I,h_box7,'circular');

figure(6);
montage({I_rep,I_sym,I_cir},'Size',[1 3]);
title('Boundary: Replicate | Symmetric | Circular');

%% 7) Save All Figures

for k = 1:6
    figure(k);
    filename = sprintf('Lab02_figure_%02d.png',k);
    saveas(gcf,filename);
end

fprintf('\nAll six figures saved successfully.\n');
