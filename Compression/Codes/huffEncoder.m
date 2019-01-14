function [Code] = huffEncoder(Prob)
%% HUFFENCODER - Encode a sequence of probabilities using Huffman coding.

%   Input
%       Prob - Probabilities (a list in descending order)

%   Output
%       Code - Huffman code of the sequence (Array of Cells for every symbol)

%% The Function starts here

Code = cell(1, length(Prob));
temp = Prob;
queue = [];

len = length(Prob);

for i= length(temp) : -1 : 1
    if i == 1
        % If queue is empty
        if isempty(queue)
            break;
        else
            Code{i} = [{1}, Code{i}];
            for j = i : length(Prob)
                Code{j} = [{0}, Code{j}];
            end
        end
    elseif temp(i) <= temp(i-1)
        % If queue is not empty
        if ~isempty(queue)
            for q =1 : length(queue)
                if queue{q}(1) < temp(i) + temp(i-1)
                    temp(i) = temp(i) + queue{q}(1);
                    Code{i-1} = [{1}, Code{i-1}];
                    for j = i : len
                        Code{j} = [{0},Code{j}];
                    end
                    temp(i-1) = temp(i) + temp(i-1);
                    
                    for j = i-1 : queue{q}(2)-1
                        Code{j} = [{1}, Code{j}];
                    end
                    
                    if q == length(queue)
                        destn = length(Prob);
                    else
                        destn = queue{q+1}(2);
                    end
                    
                    for j = queue{q}(2) : destn
                        Code{j} = [{0}, Code{j}];
                    end
                    
                    queue = queue(1 : length(queue)-1);
                end
                break;  
            end
        else
            Code{i-1} = [{1}, Code{i-1}];
            for j = i : len
                Code{j} = [{0}, Code{j}];
            end
            temp(i-1) = temp(i) + temp(i-1);
        end
    else
        % Append the queue
        queue = [{[temp(i), i]} ,queue];
        len = i-1;
    end
end

end

