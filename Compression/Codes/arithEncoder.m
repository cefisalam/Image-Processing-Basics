function [Code] = arithEncoder(Symb , Prob , Seq)
%% ARITHENCODER - Encode a sequence of symbols using arithmetic coding.

%   Input
%       Symb - List of Non-repetitive Symbols
%       Prob - Probabilities (a list in descending order)
%       Seq  - Sequence of Symbols

%   Output
%       Code - Arithmetic Code for a given sequence

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

Low = 0; % Initial Low
High = 1; % Initial High

i = 1;
Index = 0;
while i <= length(Seq)
    
    % Predict the Symol in the Sequence
    for j = 1: length(Symb)
        if Seq(i) == Symb(j)
            Index = j;
        end
    end
    
    % Encode the Sequence
    Range = High - Low;
    High  = Low + ( Range * newHigh(Index));
    Low = Low + (Range * newLow (Index));
    i = i + 1;
end

Code = Low;

code = sprintf('%f',Low)
end

