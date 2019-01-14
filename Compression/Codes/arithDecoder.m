function [Seq] = arithDecoder(Symb , Prob , Code)
%% ARITHDECODER - Decodes the sequence of symbols using arithmetic decoding.

%   Input
%       Symb - List of Non-repetitive Symbols
%       Prob - Probabilities (a list in descending order)
%       Code - Arithmetic Code of a sequence

%   Output
%       Seq  - Sequence of Symbols for a given code

%% The Function starts here

% Initialization
newHigh = zeros(length(Symb),1);
newLow = zeros(length(Symb),1);

tempH = 0;
tempL = 1;

% Calculate the Range for each Symbol (between 1 and 0)
for i = 1:length(Symb)
    
    newHigh(i) = 1 - tempH;
    tempH = tempH + Prob(i);
    tempL = tempL - Prob(i);
    newLow(i) = tempL;
end

i = Code;
Threshold = 0.01; % Avoids precision error
Seq = []; % Initialize Output Sequence
while i >= Threshold
    Index = 1;
    
    % Predict the Symbol (based on the range calculated above)
    for j = 1: length(newHigh)
        if i < newHigh(j) && i > newLow(j)
            Index=j;
            Seq = [Seq, Symb(Index)];
            break;
        end
    end
    
    % Decode the Sequence
    Range = newHigh(Index) - newLow(Index);
    i = (i - newLow(Index))./Range;
    i = vpa(i,5);   
end

seq = sprintf('%s',Seq)
end

