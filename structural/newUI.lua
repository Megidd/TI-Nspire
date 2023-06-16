platform.apilevel = '2.2'

eP, error = D2Editor.newRichText():resize(300, 40)
eP:move(0, 0):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(true):setSelectable(false):setTextColor(
    0x666666):setVisible(true)
result, error = eP:setText('Ant [net tension area]')

eE, error = D2Editor.newRichText():resize(300, 40)
eE:move(0, 50):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false):setSelectable(true)
    :setTextColor(0x000000):setVisible(true)
mbE = eE:createMathBox() -- Math Box

eR, error = D2Editor.newRichText():resize(300, 40)
eR:move(0, 100):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false):setSelectable(true)
    :setTextColor(0x000000):setVisible(true)

eD, error = D2Editor.newRichText():resize(300, 40)
eD:move(0, 150):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(true):setSelectable(true)
    :setTextColor(0x666666):setVisible(true)

-- To evaluate the expression
function run()
    local markup = mbE:getExpression()
    -- Math Box markup is "\0el {...}"
    -- Get everything between the curly braces
    local E = markup:match("{(.*)}")
    eD:setText("markup:" .. markup .. "   string:" .. E)
    local result, err = math.evalStr(E)
    if err ~= nil then
        show_error(err)
        return
    end
    eR:setText("Result: " .. result)
end

function on.escapeKey()
    run()
end

function show_error(err)
    if err == nil then
    else
        eR:setText("Error: " .. err)
    end
end
