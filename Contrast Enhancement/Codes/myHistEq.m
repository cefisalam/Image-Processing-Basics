function [histequal] = myHistEq(I)
%% MYHISTEQ - This fuction performs Histogram Equalization of the given Image, I.
%
%   Input  :    I - Input Image
%
%   Output :    histeq - Histogram Equalized Image

%% The Function starts here

[r,c]=size(I);% Read the size of Image
histequal=uint8(zeros(r,c)); % Intialize the Output Image
n=r*c; % Total no.of Pixels(row X column)

% The following variables are initialized as a vector the size 256
f=zeros(256,1); 
pdf=zeros(256,1);
cdf=zeros(256,1);
cum=zeros(256,1);
out=zeros(256,1);

% To Compute the pdf for each Intensity Value from (0-255)
for i=1:r
    for j=1:c
        val=I(i,j); % The intensity value of current pixel stored in val
        f(val+1)=f(val+1)+1; %  Icrement the count
        pdf(val+1)=f(val+1)/n; % pdf
    end
end

sum=0; 
L=255; % The total no. of intensity values (-1)

% To Compute the cdf for each Intensity Value from (0-255)
for i=1:size(pdf)
    sum=sum+f(i);
    cum(i)=sum;
    cdf(i)=cum(i)/n; % cdf
    out(i)=(cdf(i)*L); % cdf X the total intensity value
end

% To feed the equalized value back in input image
for i=1:r
    for j=1:c
        histequal(i,j)=out(I(i,j)+1);
    end
end

% Display the result
subplot(1,3,1), imshow(I);
title('Original Image');
subplot(1,3,2), imshow(histequal);
title('Histogram Equalized Image');
subplot(1,3,3), imshow(histeq(I));
title('Histogram Equalized Image (Inbuilt)');

end

