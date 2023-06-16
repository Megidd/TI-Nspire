platform.apilevel = '2.2'

desc1, error = D2Editor.newRichText():resize(200, 50)
desc1:move(0, 0):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(true):setSelectable(false)
    :setTextColor(0x666666):setVisible(true)
result, error = desc1:setText('Ant [net tension area]')

ed1, error = D2Editor.newRichText():resize(200, 50)
ed1:move(0, 60):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false):setSelectable(true)
    :setTextColor(0x000000):setVisible(true)
result, error = ed1:setText('0.0')
str, pos, sel, error = ed1:getExpressionSelection()
-- ed1:createMathBox()

ed2, error = D2Editor.newRichText():resize(200, 50)
ed2:move(0, 120):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false):setSelectable(true)
    :setTextColor(0x000000):setVisible(true)
-- d2e2:createMathBox()

-- To evaluate the expression
function run()
    local expression = ed1:getExpression()
    local result, err = math.evalStr(expression)
    if err == nil then
        ed2:setText("Result: " .. result)
    else
        ed2:setText("Error: " .. err)
    end
end

function on.escapeKey()
    run()
end
