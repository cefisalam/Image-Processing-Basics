clc;
clear;
close all;

I=imread('IA.bmp');
subplot(4,2,1)

imshow(I);
subplot(4,2,2)
imhist(I); % In-built command to show histogram of an image
H1=imhist(I);

J=imread('IB.bmp');
subplot(4,2,3)
imshow(J);
subplot(4,2,4)
imhist(J);
H2=imhist(J);

K=imread('IC.bmp');
subplot(4,2,5)
imshow(K);
subplot(4,2,6)
imhist(K);
H3=imhist(K);

L=imread('ID.bmp');
subplot(4,2,7)
imshow(L);
subplot(4,2,8),
imhist(L);
H4 = imhist(L);

A=sum(H1(101:151)); % To find the number of pixels between (100:150)
B=sum(H2(101:151));
C=sum(H3(101:151));
D=sum(H4(101:151));