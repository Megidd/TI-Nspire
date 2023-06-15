platform.apilevel = '2.2'

d2e1, error = D2Editor.newRichText():resize(200, 50)
d2e1:move(0, 0):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false):setSelectable(true)
    :setTextColor(0x000000):setVisible(true)
result, error = d2e1:setText('Ant: ')
str, pos, sel, error = d2e1:getExpressionSelection()
d2e1:createMathBox()

d2e2, error = D2Editor.newRichText():resize(200, 50)
d2e2:move(0, 60):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false):setSelectable(true)
    :setTextColor(0x000000):setVisible(true)
d2e2:setText('Expression: ' .. str)
d2e2:createMathBox()
