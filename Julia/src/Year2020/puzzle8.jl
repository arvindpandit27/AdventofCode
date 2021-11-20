lines = open("../inputFiles/Year2020/puzzle8.txt", read=true, write =true) do io
    ids_array = readlines(io)
end
function filldata!(lines, dataArray, valArray)
    for i in 1:length(lines)
        data = split(lines[i], " ")[1]
        val = parse(Int,split(lines[i], " ")[2])
        push!(dataArray, data)
        push!(valArray, val)
    end
    return dataArray, valArray
end

dataArray, valArray = filldata!(lines,[],[])


function statemachine(command, data, output)
    line = 1
    linesVisited = []
    while !(line in linesVisited) && line <= length(lines)
        if command[line] == "nop"
            push!(linesVisited, line)
            line = line + 1 
        elseif command[line] == "acc"
            push!(linesVisited, line)
            output = output + data[line]
            line = line + 1
        elseif command[line] == "jmp"
            push!(linesVisited, line)
            line = line + data[line]
        end
    end
    return output, line
end


function buggyStatemachine(command, numbers, output)
    trialList = deepcopy(command)
    IndicesOfNop = findall(x-> x=="nop", trialList)
    

    for i in 1:length(IndicesOfNop)
        trialList[IndicesOfNop[i]] = "jmp"
        val , line = statemachine(trialList, numbers, 0)
        if line < length(lines)
            trialList[IndicesOfNop[i]] = "nop"
            println("coming here")
            continue
        else
            return val, line
        end
        trialList[IndicesOfNop[i]] = "nop"
    end
    println("Cant change nops")

    trialList2 = deepcopy(command)
    IndicesOfJmp = findall(x-> x == "jmp", trialList2)
    for j in 1:length(IndicesOfJmp)
          trialList2[IndicesOfJmp[j]] = "nop"
          val , line = statemachine(trialList2, numbers, 0)
          if line < length(lines)
             trialList2[IndicesOfJmp[j]] = "jmp"
             continue
          else
             println("hitting")
              return val, line
          end
         
    end
end




output,line = statemachine(dataArray, valArray, 0)
output2 = buggyStatemachine(dataArray, valArray, 0)