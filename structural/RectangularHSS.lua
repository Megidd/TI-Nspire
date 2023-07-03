-- Affects drawing.
local prompts = {"Total height h", "Total width b", "Thick. of height plate", "Thick. of width plate"}

function logic()
    local results = {}

    local numbers = input_numbers()

    if numbers == nil or next(numbers) == nil or #numbers ~= #prompts then
        return
    end

    local Zx = plastic_section_modulus(numbers[2], numbers[1], numbers[4], numbers[3])
    results["plastic_section_modulus x"] = Zx
    local Zy = plastic_section_modulus(numbers[1], numbers[2], numbers[3], numbers[4])
    results["plastic_section_modulus y"] = Zy
    return results
end

function plastic_section_modulus(b, h, tb, th)
    local b1 = b - 2 * th
    local h1 = h - 2 * tb

    local Af = b * h / 2 -- Area: full
    local Anf = b1 * h1 / 2 -- Area: hollow
    local Df = h / 2 / 2 -- Distance of center from axis
    local Dnf = h1 / 2 / 2 -- Distance of center from axis

    local Zx = 2 * (Af * Df - Anf * Dnf) -- Plastic Section Modulus about x-axis

    return Zx
end

-- -- -- Common code for drawing.

-- '2.4' is for OS 3.7 and our OS is 3.9 so it's good.
-- https://education.ti.com/html/webhelp/EG_TINspireLUA/EN/content/libraries/aa_scriptcompat/scriptcompatibility.htm#Creating
platform.apiLevel = '2.4'

local state_error = nil
local scroll_offset = 0 -- Add a variable to track the vertical scroll offset
local scroll_offset_x = 0

local editors = {}

-- Create the rich text editors outside of the on.paint(gc) function and
-- only update their positions.
for i = 1, #prompts do
    local y = scroll_offset -- Subtract the scroll offset from the y-coordinate of the text
    local x = scroll_offset_x
    local eP, error = D2Editor.newRichText():resize(300, 40)
    eP:move(x + 8, y + (2 * i + 0) * 50):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(true)
        :setSelectable(false):setTextColor(0x666666):setVisible(true)
    eP:setText(prompts[i])

    local eI, error = D2Editor.newRichText():resize(300, 40)
    eI:move(x + 8, y + (2 * i + 1) * 50):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false)
        :setSelectable(true):setTextColor(0x000000):setVisible(true)
    eI:setText("0")

    editors[2 * i + 0] = eP
    editors[2 * i + 1] = eI
end

function on.paint(gc)
    if state_error == nil then
    else
        gc:setColorRGB(255, 255, 255)
        gc:fillRect(0, 0, 320, 240)
        gc:setColorRGB(0, 0, 0)
        gc:setFont("sansserif", "r", 12)
        gc:drawString(state_error, 50, 120)
        return
    end

    local y = scroll_offset -- Subtract the scroll offset from the y-coordinate of the text
    local x = scroll_offset_x

    for i = 1, #prompts do
        local eP = editors[2 * i + 0]
        local eI = editors[2 * i + 1]

        eP:move(x + 8, y + (2 * i + 0) * 50)
        eI:move(x + 8, y + (2 * i + 1) * 50)
    end

    local yOffset = y + #prompts * 100
end

function run()
    -- Draw results.
    local results = logic()

    if results == nil or next(results) == nil then
        return
    end

    local index = 1
    for key, value in pairs(results) do
        gc:drawString(key .. " : " .. value, x + 8, yOffset + (index - 1) * 20)
        index = index + 1
    end
end

function reset()
    state_error = nil
    scroll_offset = 0
    scroll_offset_x = 0
    platform.window:invalidate()
end

function on.tabKey()
    local scroll_step = 20
    scroll_offset = scroll_offset - scroll_step
    platform.window:invalidate()
end

function on.backtabKey()
    local scroll_step = 20
    scroll_offset = scroll_offset + scroll_step
    platform.window:invalidate()
end

function delete_markup(strI)
    if strI == nil then
        return nil
    end
    -- Math Box markup is "\0el {...}"
    -- Remove all occurrences of "\0el {" and "}" inside string
    local strO = strI:gsub("\\0el {(.-)}", "%1")
    return strO
end

function show_error(err)
    if err == nil then
    else
        state_error = err
    end
    platform.window:invalidate()
end

function input_numbers()
    local numbers = {}
    for i = 1, #prompts do
        local eP = editors[2 * i + 0]
        local eI = editors[2 * i + 1]
        local general = eI:getExpression()
        local E = delete_markup(general)
        if E == nil then
            return nil
        end
        local number, err = math.evalStr(E)
        if err ~= nil then
            show_error(err)
            return nil
        end
        table.insert(numbers, number)
    end
    return numbers
end

menu = {{"Run", run}, "-", {"Reset", reset}}

toolpalette.register(menu)
