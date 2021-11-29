lines = open("inputFiles/Year2020/puzzle5.txt", read=true, write =true) do io
    ids_array = readlines(io)
end

function modify(lines)
        for (ind, line) in zip(1:length(lines), lines)
            lines[ind] = replace(line, "F" => "0")
           lines[ind] = replace(lines[ind], "B" => "1")
           lines[ind] = replace(lines[ind], "R" => "1")
           lines[ind] = replace(lines[ind], "L" => "0")
        end
    return lines
end

modifiedInput = modify(lines)

function findRowCol!(modifiedInput, row, col)
for i in 1:length(modifiedInput)
row[i] = parse.(Int, modifiedInput[i][1:end-3], base = 2)
col[i] = parse.(Int, modifiedInput[i][end-2:end], base = 2)
end
return row, col
end

Rows, Cols = findRowCol!(modifiedInput,zeros(length(modifiedInput)),zeros(length(modifiedInput)))
maxID = maximum(Rows*8 .+ Cols)
AllIDs = sort(Rows*8 .+ Cols)

for j in 1:length(AllIDs)-1
    if AllIDs[j] - AllIDs[j+1] == -2
        println(AllIDs[j]+1)
    end
end
