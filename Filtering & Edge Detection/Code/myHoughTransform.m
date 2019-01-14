function [Hough, theta_range, rho_range] = myHoughTransform(Img, N)
% MYHOUGHTRANSFORM takes an image as input and detects N longest lines using
% Hough Transform
%
%   Input
%       I - Image
%       N - No. of lines to be drawn
%
% Output
%       Hough - Hough Transform of an Image

%% Function starts here

% Convert the Image to GrayScale
if size(Img,3) == 3
    Img = rgb2gray(Img);
end

% Extract the Edges
I = edge(Img, 'canny');
% figure, imshow(BW), title('Canny Edge Detection ');

[r, c] = size(I);

% Set Rho theta Range
theta_maximum = 90;
rho_maximum = floor(sqrt(r^2 + c^2)) - 1;
theta_range = -theta_maximum:theta_maximum - 1;
rho_range = -rho_maximum:rho_maximum;

% Initialize Hough Matrix
Hough = zeros(length(rho_range), length(theta_range));

wb = waitbar(0, 'Finding Hough Transform');

% Finding the Hough Transform
for row = 1:r
    waitbar(row/r, wb);
    for col = 1:c
        if I(row, col) > 0
            x = col - 1;
            y = row - 1;
            for theta = theta_range
                % Conversion from Image Space to Feature (Parametric) Space
                rho = round((x * cosd(theta)) + (y * sind(theta)));
                rho_index = rho + rho_maximum + 1;
                theta_index = theta + theta_maximum + 1;
                Hough(rho_index, theta_index) = Hough(rho_index, theta_index) + 1;
            end
        end
    end
end

close(wb);
%  figure, imagesc(theta_range,rho_range,Hough),title('Hough Transform');

% To Draw N longest lines on the Image
[temp, ~] = sort (Hough, 'descend');
figure, imshow(Img), title('Hough Lines'), hold on;
Er =0;

for i = 1:N
    [r, c] = find(Hough==temp(i));
    for j= 1: numel(r)
        rho = rho_range(r(j));
        theta = theta_range(c(j));
        x = 1:size(I, 2);
        % Conversion from Feature Space to Image Space
        y = round((rho - x * cosd(theta)) / sind(theta));
        plot(x, y, 'g-');
        Er = Er+1;
        if Er == N
            break;
        end
    end
    if Er == N
        break;
    end
end
hold off;

end
