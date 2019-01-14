function [P] = powerLawTrans(I,C, gamma)
%% POWERLAWTRANS - This fuction enhances the contranst of brighter regions of
%an image, I.
%   Input  :    I - Input Image
%               C - is a constant
%               gamma - The power value (generally called gamma correction) 
%
%   Output :    P - Output of Power Law Tranformation

%% The Function starts here
I=im2double(I); % Convert Image to Double
[r,c]=size(I); % Read the size of image

P=zeros(r,c); % Intialize the Output Image

for i=1:r
    for j=1:c
        P(i,j)=C*I(i,j).^gamma; % Implementation of Gamma Correction
    end
end

% Display the result
subplot(1,2,1), imshow(I);
title('Original Image')
subplot(1,2,2), imshow(P);
title('Enhanced Image (Gamma Correction)')

end