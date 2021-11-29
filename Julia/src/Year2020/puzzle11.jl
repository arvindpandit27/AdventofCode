using DelimitedFiles

lines = open("../inputFiles/Year2020/puzzle11.txt", read=true, write =true) do io
    ids_array = readlines(io)
end

function mod(lines, val)
 
for i in 1:length(lines)

 val = append!(val,  split(lines[i],""))
end
return val
end

# function modify(lines)
#         for (ind, line) in zip(1:length(lines), lines)
#             lines[ind] = replace(line, "L" => "0 ")
#            lines[ind] = replace(lines[ind], "#" => "2 ")
#            lines[ind] = replace(lines[ind], "." => "-100 ")
#         end

# end
val = []
a = mod(lines, val)


# modifiedInput = modify(lines)

