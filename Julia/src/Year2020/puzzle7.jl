

lines = open("../inputFiles/Year2020/puzzle7_dummy.txt", read=true, write =true) do io
    ids_array = readlines(io)
end

regex = r"(.+) contain"
funs = eachmatch.(regex, lines)
ParentBag = unique(x[1] for x in funs)
ChildrenBag = unqiue(x[3] for x in funs)
ChildrenBag = unqiue(x[5] for x in funs)