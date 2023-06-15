platform.apilevel = '2.2'

ed1, error = D2Editor.newRichText():resize(200, 50)
ed1:move(0, 0):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false):setSelectable(true)
    :setTextColor(0x000000):setVisible(true)
result, error = ed1:setText('Ant: ')
str, pos, sel, error = ed1:getExpressionSelection()
ed1:createMathBox()

ed2, error = D2Editor.newRichText():resize(200, 50)
ed2:move(0, 60):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false):setSelectable(true)
    :setTextColor(0x000000):setVisible(true)
ed2:setText('Expression: ' .. str)
-- d2e2:createMathBox()
