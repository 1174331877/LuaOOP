TableUtil = {}
function TableUtil.HasValue(t, vavlue)
    for k, v in pairs(t) do
        if v == vavlue then
            return true
        end
    end
    return false
end

function TableUtil.HasKey(t, key)
    for k, v in pairs(t) do
        if k == key then
            return true
        end
    end
    return false
end
