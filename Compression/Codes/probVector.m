function [Prob] = probVector(I)
%% PROBVECTOR - finds the Probability of each intensity levels present in the image (I).
%   Input
%       I - Input Image

%   Output
%       Prob - Probability of intensity levels (in descending order)

%% The Function starts here

[r, c]= size(I); % Read the size of the image
Prob = zeros(1, 256); % Initialize Output Array of Probabilities
len = length(Prob);
for i = 1:r
    for j = 1:c
        Prob(I(i,j)) = Prob(I(i,j)) + 1;
    end
end

% Calculate the Probability for each intensity level
Prob = sort (Prob ,'descend');
Prob = vpa(Prob ./ (r*c));

% Truncate the Output Array by removing zero probability
Limit = 0;
for i=1:len
    if Prob(i) > 0
        continue;
    else
        Limit = i;
        break;
    end
end

Prob = Prob(1:Limit-1);

prob = sprintf('%f',Prob)
end

