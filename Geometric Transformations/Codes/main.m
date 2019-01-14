clear; close all; clc;
%% Translation - Rotation and Interpolation

I = imread('lena.jpeg');
myTranslation(I, 30, 30);

% J = imread('cameraman.tif');
% myRotation(J, -45, 'bilinear');

%% Projective Transformation

% Input = imread('plate_side.jpg');
% Ref = imread('plate_reference.jpg');
% projectiveTransform(Input, Ref);

%% Procrustes Analysis

% M = load('star_points.mat');
% myProcrustes(M.input_points,M.base_points);