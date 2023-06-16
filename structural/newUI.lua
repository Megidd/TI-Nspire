platform.apilevel = '2.2'

eP, error = D2Editor.newRichText():resize(200, 40)
eP:move(0, 0):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(true):setSelectable(false):setTextColor(
    0x666666):setVisible(true)
result, error = eP:setText('Ant [net tension area]')

eE, error = D2Editor.newRichText():resize(200, 40)
eE:move(0, 50):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false):setSelectable(true)
    :setTextColor(0x000000):setVisible(true)
result, error = eE:setText('0.0')

eR, error = D2Editor.newRichText():resize(200, 40)
eR:move(0, 100):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false):setSelectable(true)
    :setTextColor(0x000000):setVisible(true)

eD, error = D2Editor.newRichText():resize(200, 40)
eD:move(0, 150):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(true):setSelectable(true)
    :setTextColor(0x666666):setVisible(true)

-- To evaluate the expression
function run()
    local expression = eE:getExpression()
    eD:setText(expression)
    local result, err = math.evalStr(expression)
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
