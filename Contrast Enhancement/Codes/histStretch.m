function [S] = histStretch(I)
%% HISTSTRETCH - This fuction performs Histogram Equalization of the given Image, I.
%
%   Input  :    I - Input Image
%
%   Output :    S - Histogram Stretched Image

%% The Function starts here

I = double(I); % Convert Image to Double
[r,c]=size(I); % Read the size of image

a=min(I(:)); % Minimum Intensity level of given image 
b=max(I(:)); % Maximum Intensity level of given image

S=zeros(r,c); % Intialize the Output Image

% The formula for Histogram Stretching has been implemented as follows
for i=1:r
    for j=1:c
        if I(i,j)<a
            S(i,j)=0;
        elseif I(i,j)>b
            S(i,j)=255;
        else
            S(i,j) = 255*(I(i,j)-a)/(b-a);
        end
    end
end

% Display the result
subplot(2,2,1), imshow(I, []);
title('Original Image');
subplot(2,2,2), imshow(S, []);
title('Histogram Stretched Image');
subplot(2,2,3), imhist(uint8(I));
title('Histogram of Original Image');
subplot(2,2,4), imhist(uint8(S));
title('Histogram of Stretched Image');

end