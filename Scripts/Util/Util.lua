function SuperStringSplit(strn, chars)
    function stringPatch(str)
        --格式化输入包含特殊符号的分割字符
        local str_p =
            str:gsub('%)', '% %)'):gsub('%(', '%%('):gsub('%[', '%%['):gsub('%]', '%%]'):gsub('%:', '%%:'):gsub(
            '%;',
            '%%;'
        ):gsub('%+', '%%+'):gsub('%-', '%%-')
        return str_p
    end
    function jbyteCount(jstr)
        local lenInByte = #jstr
        local tbyteCount = {}
        local totallen = 0
        for i = 1, lenInByte do
            --计算传入的字符串的每一个字符长度
            local curByte = string.byte(jstr, i)

            local byteCount = 0 --这里的初始长度设为0
            if curByte > 0 and curByte <= 127 then
                byteCount = 1
            elseif curByte >= 192 and curByte < 223 then
                byteCount = 2
            elseif curByte >= 224 and curByte < 239 then
                byteCount = 3
            elseif curByte >= 240 and curByte <= 247 then
                byteCount = 4
            end
            table.insert(tbyteCount, byteCount)
            totallen = totallen + byteCount
        end
        -- print('totallen长度:',totallen);
        return totallen, tbyteCount
    end

    --第二参数可省略 此时默认每个字符分割
    if not chars then
        chars = ''
    end
    --没有第一参数或为空值时报错
    if not strn then
        return 'zsplit 错误: #1 nil 参数1为空值!'
    end
    local strSun = {}
    if chars == '' then
        --[[当默认每个字符分割时的补充方案.
            因为遇到分割中文时，因为长度问题导致分割错误
      ]]
        local lenInByte = #strn
        local width = 0
        local fuckn = 0
        for i = 1, lenInByte do
            --计算传入的字符串的每一个字符长度
            local curByte = string.byte(strn, i)
            local byteCount = 1
            if curByte > 0 and curByte <= 127 then
                byteCount = 1
            elseif curByte >= 192 and curByte < 223 then
                byteCount = 2
            elseif curByte >= 224 and curByte < 239 then
                byteCount = 3
            elseif curByte >= 240 and curByte <= 247 then
                byteCount = 4
            end
            local char = string.sub(strn, i, i + byteCount - 1)
            fuckn = i + byteCount - 1
            if (i ~= fuckn or curByte < 127) then
                table.insert(strSun, char)
            end
            if (i == #strn) then
                return strSun
            end
        end
    else
        --endsign结束标志
        local endsign = 1
        local ongsubs, gsubs = string.gsub(strn, stringPatch(chars), chars)
        print('\n替换结束:', ongsubs, '\n替换次数:', gsubs, '\n源字符串:', strn, '\n格式化匹配条件:', stringPatch(chars), '\n源匹配条件', chars)
        for i = 0, gsubs do
            local wi = string.find(ongsubs, stringPatch(chars))
            --print('匹配条件所在位置:',wi);
            if (wi == nil) then
                --当没有匹配到条件时 截取当前位置到最后一个位置
                wi = -1
                endsign = 0
            end
            local acc = string.sub(ongsubs, 1, wi - endsign)
            table.insert(strSun, acc)
             -- (string.gsub(acc, stringPatch(chars), '')));
            ongsubs = string.sub(ongsubs, wi + jbyteCount(chars), -1)
        end
    end
    return strSun
end
