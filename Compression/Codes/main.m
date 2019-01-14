clc;
clear;
close all;

%% ~~~~~~~~~~~~~~~~~~~ Arithmetic Coding ~~~~~~~~~~~~~~~~~~~

% Encoder
Symb = ['A','C','T','G'];
Prob = [0.5 , 0.3 ,0.15 , 0.05];
Seq = [ 'A' , 'C', 'T', 'A' , 'G', 'C'];

Encode = arithEncoder(Symb , Prob , Seq);

% Decoder
Decode = arithDecoder(Symb , Prob , Encode);

%% ~~~~~~~~~~~~~~~~~~~~~ Huffman Coding ~~~~~~~~~~~~~~~~~~~~

% Read an image
I = imread('lena.bmp');

% Convert image into probability list (in descending order)
I_Prob = probVector(I);

Huff_Result = huffEncoder(I_Prob);

%% ~~~~~~~~~~~~~~~~~~~~~~ JPEG Coding ~~~~~~~~~~~~~~~~~~~~~~
 
Jpeg_Result = jpegEncoder(I);


