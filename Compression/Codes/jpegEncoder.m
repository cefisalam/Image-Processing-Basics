function [O] = jpegEncoder(I)
%% PROBVECTOR - finds the Probability of each intensity levels present in the image (I).

%   Input
%       I - Input Image

%   Output
%       O - JPEG encoded values

%% The Function starts here

% Level shift image by 2^(m-1)
I = double(I) - 128;
[M , N ] = size(I);
imshow(I);
imwrite(I,'Level_Shifted_Input.bmp','bmp');

% Default JPEG Normalizing Array
Z = [16  11  10  16  24  40  51  61;
     12  12  14  19  26  58  60  55;
     14  13  16  24  40  57  69  56;
     14  17  22  29  51  87  80  62;
     18  22  37  56  68  109 103 77;
     24  35  55  64  81  104 113 92;
     49  64  78  87  103 121 120 101;
     72  92  95  98  112 100 103 99; ];

% Zigzag Re-ordering Pattern
order = [1  9  2  3  10 17 25 18 11 4  5  12 19 26 33 41 ...
         34 27 20 13 6  7  14 21 28 35 42 49 57 50 43 36 ...
         29 22 15 8  16 23 30 37 44 51 58 59 52 45 38 31 ...
         24 32 39 46 53 60 61 54 47 40 48 55 62 63 56 64 ];

% Transformation Matrix
H = dctmtx(8);

%2D DCT cosine Transform
B = blkproc(I, [8 8], 'P1 * x * P2', H, H');

%Quantization and Normalization
O = blkproc(B, [8 8], 'round(x ./ P1)', Z);
figure(), imshow(O);
imwrite(O,'Compressed_Output.bmp','bmp');

% Break 8 x 8 blocks into Columns
O = im2col(O, [8 8], 'distinct');

% Number of Blocks
dim = size(O, 2);
O = O(order, :);

% Create end-of-block Symbol
EOB = max(I(:)) + 1;
r = zeros(numel(O) + size(O, 2), 1);
count = 0;

% To Process one Block (one Column) at a time
for j = 1:dim
    i = find(O(:, j), 1, 'last');   % Find last non-zero element
    if isempty(i)                   % Check if there are no non-zero values
        i = 0;
    end
    p = count + 1;
    q = p + i;
    r(p:q)  = [O(1:i, j); EOB];     % Truncate trailing zeros, add eob
    count = count + i + 1;          % Add to Output vector
end

r((count + 1):end) = [];            % Delete unused portion of r
O           = struct;
O.size      = uint16([M N]);
O.blockNo   = uint16(dim);
O.huffman   = huffEncoder(r);

end

