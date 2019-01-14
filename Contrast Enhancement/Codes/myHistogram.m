function [ h ] = myHistogram(I)
%% MYHISTOGRAM - This fuction computes the Histogram of the given Image, I.
%
%   Input  :    I - Input Image
%
%   Output :    h - Histogram of the Input Image

%% The Function starts here

[r,c]=size(I); % Read the size of image
t=1:256; 
n=0:255; % Represents the total no. of Intensity values 
count=0;
for z=1:256
    for i=1:r
        for j=1:c
            
            if I(i,j)==z-1 % If the current pixel has (z-1) value as intensity,
                count=count+1; %Increment count by 1.
            end
        end
    end
            t(z)=count; % Load the count of pixels for each intensity value in 't'
            count=0;
end
    
    subplot(2,1,1), imshow(I);
    title('Original Image');
    
    subplot(2,1,2), h = stem(n,t,'Marker', 'None'); % Display the Histogram
    title('Histogram of Original Image');
end
