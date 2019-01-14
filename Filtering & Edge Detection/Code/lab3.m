clc;
clear;
close all;

%% Exercise 1 - Image Filters

% Input Image and Filter
I = imread('building.jpg');
M = [1 4 1; 4 16 4; 1 4 1]/36;

% Filtering
F1 = imfilter(I,M);

figure,
subplot(121), imshow(I,[]), title('Input Image');
subplot(122), imshow(F1,[]), title('Filtered Image');

% Different types of Border Restoration
F2 = imfilter(I,M,'symmetric');
F3 = imfilter(I,M,'circular');
F4 = imfilter(I,M,'replicate');

figure,
subplot(221), imshow(F1,[]), title('Filtered Image');
subplot(222), imshow(F2,[]), title('Filtered Image (Symmetric)');
subplot(223), imshow(F3,[]), title('Filtered Image (Circular)');
subplot(224), imshow(F4,[]), title('Filtered Image (Replicate)');

%% Exercise 1.1 - Linear Filtering

% Input Image and Filters
I2 = imread('saturn.png');
M_avg = ones(3)/9;
M_gauss = [1 4 1; 4 16 4; 1 4 1]/36;

% Filtering
F_avg = imfilter(I2,M_avg, 'replicate');
F_gauss = imfilter(I2,M_gauss, 'replicate');

figure,
subplot(221), imshow(F_avg,[]), title('Average Filtered Image');
subplot(222), plot(F_avg(100,:)), title('Plot Average Filter Response');
subplot(223), imshow(F_gauss,[]), title('Gauss Filtered Image');
subplot(224), plot(F_gauss(100,:)), title('Plot Gauss Filter Response');

I3 = imread('saturn_noise.png');

% Filtering
F_avg1 = imfilter(I3,M_avg, 'replicate');
F_gauss1 = imfilter(I3,M_gauss, 'replicate');

figure,
subplot(221), imshow(I3,[]),title('Input Image');
subplot(222), plot(I3(100,:)), title('Plot Input  Response');
subplot(223), imshow(F_avg1,[]), title('Average Filtered Image');
subplot(224), plot(F_avg1(100,:)), title('Plot Average Filter Response');

figure,
subplot(221), imshow(I3,[]), title('Input Image');
subplot(222), plot(I3(100,:)), title('Plot Input  Response');
subplot(223), imshow(F_gauss1,[]), title('Gauss Filtered Image');
subplot(224), plot(F_gauss1(100,:)), title('Plot Gaussian Filter Response');

%% Exercise 1.2 - Non-linear Filtering

I4 = imread('saturn_noise2.png');

% Filtering
F_med = medfilt2(I4);
F_avg2 = imfilter(I4,M_avg, 'symmetric');
F_gauss2 = imfilter(I4,M_gauss, 'symmetric');

figure,
subplot(221), imshow(I4,[]), title('Input Image');
subplot(222), imshow(F_med,[]), title('Median Filtered Image');
subplot(223), imshow(F_avg2,[]), title('Average Filtered Image');
subplot(224), imshow(F_gauss2,[]), title('Gaussian Filtered Image');

%% Exercise 2 - Edge Detection

%% Exercise 2.1 - Sobel Filters

% Input Image and Sobel Edge Filter
I5 = imread('saturn.png');

Mx = [1 0 -1; 2 0 -2; 1 0 -1];
My = [1 2 1; 0 0 0 ; -1 -2 -1];
Ix = imfilter(I5, Mx);
Iy = imfilter(I5, My);

figure,
subplot(221), imshow(Ix, []), title('Sobel Vertical Edge');
subplot(222), imshow(Iy, []), title('Sobel Horizontal Edge');

Ix = im2double(Ix);
Iy = im2double(Iy);

[r,c]=size(I5);
Norm = zeros(size(I5));

% Compute the norm of the gradient vector
for i = 1:r
    for j = 1:c
        Norm(i,j) = sqrt((Ix(i,j)*Ix(i,j))+(Iy(i,j)*Iy(i,j)));
    end
end

subplot(223), imshow(Norm, []), title('Norm of Gradient Vector');

% Thresholding of Filtered Image
Output = zeros(size(I5));
Threshold = 0.7;

for i = 1:r
    for j = 1:c
        if Norm(i,j) > Threshold
            Output(i,j) = 255;
        else
            Output(i,j) = 0;
        end
    end
end

subplot(224), imshow(Output, []), title('Sobel Threshold Image');

%% Exercise 2.2 - Comparision between Different Edge Detectors

I6 = imread('house.jpg');
I7 = rgb2gray(imread('satellite.jpg'));
I8 = rgb2gray(imread('railway.jpg'));

E1_sobel = edge(I6, 'sobel');
E1_prewitt = edge(I6, 'prewitt');
E1_canny = edge(I6, 'canny');

E2_sobel = edge(I7, 'sobel');
E2_prewitt = edge(I7, 'prewitt');
E2_canny = edge(I7, 'canny');

E3_sobel = edge(I8, 'sobel');
E3_prewitt = edge(I8, 'prewitt');
E3_canny = edge(I8, 'canny');

figure,
subplot(221), imshow(I6,[]), title('Input Image');
subplot(222), imshow(E1_sobel), title('Sobel Edge Detectors');
subplot(223), imshow(E1_prewitt), title('Prewitt Edge Detectors');
subplot(224), imshow(E1_canny), title('Canny Edge Detectors');

figure,
subplot(221), imshow(I7,[]), title('Input Image');
subplot(222), imshow(E2_sobel), title('Sobel Edge Detectors');
subplot(223), imshow(E2_prewitt), title('Prewitt Edge Detectors');
subplot(224), imshow(E2_canny), title('Canny Edge Detectors');

figure,
subplot(221), imshow(I8,[]), title('Input Image');
subplot(222), imshow(E3_sobel), title('Sobel Edge Detectors');
subplot(223), imshow(E3_prewitt), title('Prewitt Edge Detectors');
subplot(224), imshow(E3_canny), title('Canny Edge Detectors');

%% Excersise 3 - Hough Transform
% Img = imread('biblio.jpg');
% [Hough, theta_range, rho_range] = myHoughTransform(Img, 4);

Img = imread('railway.jpg');
[Hough, theta_range, rho_range] = myHoughTransform(Img, 10);
