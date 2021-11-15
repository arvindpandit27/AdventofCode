using CSV, DataFrames

input = CSV.read("E:\\rbionics\\EXO\\Data\\RX_testfolder\\puzzle.csv", DataFrame)


inputarr = input[:,:Data]


function puzzle1_parta_2020(list)

    for i in 1:length(list)
        for j in 1:length(list)
            if list[i] + list[j] == 2020
            return list[i],list[j]
            end
        end
    end

end

function puzzle1_partb_2020(list)

    for i in 1:length(list)
        for j in 1:length(list)
            for k in 1:length(list)
                if list[i] + list[j] + list[k] == 2020
                return list[i],list[j], list[k]
                end
            end
        end
    end
end


ind1, ind2 = puzzle1_parta_2020(inputarr)
ans = ind1*ind2

ind1, ind2, ind3 = puzzle1_partb_2020(inputarr)
ans = ind1*ind2*ind3