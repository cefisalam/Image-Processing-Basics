function [Projected_image] = projectiveTransform(I, ref)
%MYPROCRUSTES Function that stretches or contracts the input points set to fit the reference points set.
%   Input
%       I - Input image 
%       Y - Reference image
%
%   Output
%       O - Output Image (after projective transformation)

%% Function starts here

% Get coordinates of input and reference image
figure, imshow(I), title('Input Image');
[x,y] = ginput(4);

figure, imshow(ref), title('Reference Image');
[x1, y1] = ginput(4);

X = [x,y];
Y = [x1,y1];

% Perform Projective Transformation [fitgeotrans is same as cp2tform]
T = fitgeotrans(X, Y, 'projective');

% Apply Transformation on the input image [imwarp is same as imtransform]
Projected_image = imwarp(I, T);
figure, imshow(Projected_image), title('Projective Transformation');

% Crop the Transformed image
[~, rect] = imcrop(Projected_image);
Img_crop = imcrop(Projected_image, rect);
figure, imshow(Img_crop), title('Cropped Image (After Transformation)');

end

