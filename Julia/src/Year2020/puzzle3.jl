#try
lines = open("inputFiles/Year2020/puzzle3.txt", read=true, write =true) do io
    ids_array = readlines(io)
end

function modify(lines)
        for (ind, line) in zip(1:length(lines), lines)
            lines[ind] = replace(line, "#" => "1 ")
           lines[ind] = replace(lines[ind], "." => "0 ")
        end
    return lines
end

modifiedInput = modify(lines)


function makeMatrix(modifiedInput)
    MatrixInput = Matrix{Int64}(undef, length(modifiedInput),  length(split(modifiedInput[1])))
for i in 1:length(modifiedInput)
    parsedvals = parse.(Int64,split(modifiedInput[i]))
    MatrixInput[i, :] = parsedvals
end
return MatrixInput
end

function appendMatrix(input, xMove, yMove)
        ColsRequired = (xMove/yMove)*size(input,1)
        ColsPresent = size(input,2)
        appends = ceil(ColsRequired/ColsPresent)
        appended = copy(input)
        for i in 1:appends-1
         input =  hcat(input, appended)
        end

    return input   
end

Input = makeMatrix(modifiedInput)
xMove = 3
yMove = 1
BigColMatrix = appendMatrix(Input, xMove, yMove)

function treecounter(counter, BigColMatrix, xMove, yMove, Row, Column)
while(Row <= size(BigColMatrix,1))
    if BigColMatrix[Row,Column] == 1
        counter = counter + 1
    end
    Column = Column + xMove
    Row = Row + yMove
    #println(Row, " ",  Column)
end
return counter
end

numTrees_slope1 = treecounter(0, appendMatrix(Input, 1, 1), 1, 1, 1, 1)
numTrees_slope2 = treecounter(0, appendMatrix(Input, 3, 1), 3, 1, 1, 1)
numTrees_slope5 = treecounter(0, appendMatrix(Input, 1, 2), 1, 2, 1, 1)
numTrees_slope3 = treecounter(0, appendMatrix(Input, 5, 1), 5, 1, 1, 1)
numTrees_slope4 = treecounter(0, appendMatrix(Input, 7, 1), 7, 1, 1, 1)


ans = numTrees_slope1*numTrees_slope2*numTrees_slope3*numTrees_slope4*numTrees_slope5