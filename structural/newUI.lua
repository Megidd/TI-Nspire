platform.apilevel = '2.2'

desc1, error = D2Editor.newRichText():resize(200, 40)
desc1:move(0, 0):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(true):setSelectable(false)
    :setTextColor(0x666666):setVisible(true)
result, error = desc1:setText('Ant [net tension area]')

ed1, error = D2Editor.newRichText():resize(200, 40)
ed1:move(0, 50):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false):setSelectable(true)
    :setTextColor(0x000000):setVisible(true)
result, error = ed1:setText('0.0')
str, pos, sel, error = ed1:getExpressionSelection()
-- ed1:createMathBox()

ed2, error = D2Editor.newRichText():resize(200, 40)
ed2:move(0, 100):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false):setSelectable(true)
    :setTextColor(0x000000):setVisible(true)
-- d2e2:createMathBox()

ed3, error = D2Editor.newRichText():resize(200, 40)
ed3:move(0, 150):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(true):setSelectable(false)
    :setTextColor(0x666666):setVisible(true)

-- To evaluate the expression
function run()
    local expression = ed1:getExpression()
    local err = var.store("expression", expression)
    if err ~= nil then
        show_error(err)
        return
    end
    local result, err = math.evalStr("string(expression)")
    if err ~= nil then
        show_error(err)
        return
    end
    ed3:setText(expression)
    ed2:setText("Result: " .. result)
end

function on.escapeKey()
    run()
end

function show_error(err)
    if err == nil then
    else
        ed2:setText("Error: " .. err)
    end
end
