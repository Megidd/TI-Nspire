platform.apilevel = '2.2'

box_prompt, error = D2Editor.newRichText():resize(300, 40)
box_prompt:move(0, 0):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(true):setSelectable(false)
    :setTextColor(0x666666):setVisible(true)
result, error = box_prompt:setText('Please enter an expression in box below')

box_expr, error = D2Editor.newRichText():resize(300, 40)
box_expr:move(0, 50):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false):setSelectable(true)
    :setTextColor(0x000000):setVisible(true)

box_result, error = D2Editor.newRichText():resize(300, 40)
box_result:move(0, 100):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false):setSelectable(true)
    :setTextColor(0x000000):setVisible(true)

box_expr_doublecheck, error = D2Editor.newRichText():resize(300, 40)
box_expr_doublecheck:move(0, 150):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(true):setSelectable(
    false):setTextColor(0x666666):setVisible(true)

-- To evaluate the expression
function run()
    local expression = box_expr:getExpression()
    box_expr_doublecheck:setText("expression doublecheck: "..expression)
    local result, err = math.evalStr(expression)
    if err ~= nil then
        show_error(err)
        return
    end
    box_result:setText("Result: " .. result)
end

function on.escapeKey()
    run()
end

function show_error(err)
    if err == nil then
    else
        box_result:setText("Error: " .. err)
    end
end
