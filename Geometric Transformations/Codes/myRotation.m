function [O] = myRotation(I, ang, method)
%MYROTATION rotates the image from its centre with an angle 'theta'.
%   Input
%       I       - Input Image
%       ang     - Angle of Rotation
%       method  - Interpolation method {'nearest', 'bilinear'}
%
%
%   Output
%       O - Rotated Image

%% Function starts here

I = im2double(I);

theta=(ang)*pi/180; % Angle of Rotation

[r, c] = size(I); % Size of the Image

O = zeros(size(r,c));

midx = r./2; % Midpoint of x-axis
midy = c./2; % Midpoint of y-axis

for i=1:r
    for j=1:c
        
        % Rotation steps (based on the Formula)
        x=(i-midx)*cos(theta)-(j-midy)*sin(theta);
        y=(i-midx)*sin(theta)+(j-midy)*cos(theta);
        x1=round(x)+midx;
        y1=round(y)+midy;
        
        % Interpolation steps
        if (1 <= x1 && x1 < r && 1 <= y1 && y1 < c)
            up = floor(x1);
            down = up+1;
            left = floor(y1);
            right = left+1;
            
            intensity_1 =  I(up, left);
            intensity_2 =  I(down, left);
            intensity_3 =  I(up, right);
            intensity_4 =  I(down, right);
            
            switch method % Select one method to interpolate
                case 'nearest' % Nearest Neighbor Interpolation
                    
                    if (down <= r && right <= c)
                        intensity = (intensity_1 + intensity_2 + intensity_3 + intensity_4)/4;
                    end
                    
                case 'bilinear' % Bilinear Interpolation
                    
                    if (down <= r && right <= c)
                        leftIntensity = (x1-up) * (intensity_2 - intensity_1) + intensity_1;
                        rightIntensity = (x1-up) * (intensity_4 - intensity_3) + intensity_3;
                        intensity = (y1 - left) * (rightIntensity - leftIntensity) + leftIntensity;
                    end
            end
        else
            intensity = 0; % Parts other than input image appears black
        end
        O(i,j)=intensity; % Store the output image
    end
end

% Display the Result
figure,
subplot(1,2,1),imshow(I), title('Original Image');
subplot(1,2,2),imshow(O), title('Rotated Image');

end

