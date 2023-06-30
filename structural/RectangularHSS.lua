-- -- -- Input
local numbers = {"", "", "", ""}
local prompts = {"h: ", "b: ", "t of h plates: ", "t of b plates: "}
local descriptions = {"Total height", "Total width", "Thickness of height plate", "Thickness of width plate"}

-- -- -- Logic

function logic()
    local results = {}

    local h = tonumber(numbers[1])
    local b = tonumber(numbers[2])
    local th = tonumber(numbers[3])
    local tb = tonumber(numbers[4])

    local Zx = plastic_section_modulus(b, h, tb, th)
    results["plastic_section_modulus x"] = Zx
    local Zy = plastic_section_modulus(h, b, th, tb)
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

-- -- -- Common code

-- '2.4' is for OS 3.7 and our OS is 3.9 so it's good.
-- https://education.ti.com/html/webhelp/EG_TINspireLUA/EN/content/libraries/aa_scriptcompat/scriptcompatibility.htm#Creating
platform.apiLevel = '2.4'

local current_state = 1
local scroll_offset = 0 -- Add a variable to track the vertical scroll offset
local scroll_offset_x = 0

local editors = {}

-- Create the rich text editors outside of the on.paint(gc) function and
-- only update their positions.
for i = 1, #numbers do
    local y = scroll_offset -- Subtract the scroll offset from the y-coordinate of the text
    local x = scroll_offset_x
    local eP, error = D2Editor.newRichText():resize(300, 40)
    eP:move(x + 8, y + (2 * i + 0) * 50):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(true)
        :setSelectable(false):setTextColor(0x666666):setVisible(true)
    eP:setText(prompts[i] .. "  " .. descriptions[i])

    local eI, error = D2Editor.newRichText():resize(300, 40)
    eI:move(x + 8, y + (2 * i + 1) * 50):setBorder(1):setBorderColor(0x43adee):setFontSize(12):setReadOnly(false)
        :setSelectable(true):setTextColor(0x000000):setVisible(true)
    eI:setText(prompts[i] .. "  " .. descriptions[i])

    editors[2 * i + 0] = eP
    editors[2 * i + 1] = eI
end

function on.paint(gc)
    local y = scroll_offset -- Subtract the scroll offset from the y-coordinate of the text
    local x = scroll_offset_x

    for i = 1, #numbers do
        local eP = editors[2 * i + 0]
        local eI = editors[2 * i + 1]

        eP:move(x + 8, y + (2 * i + 0) * 50)
        eI:move(x + 8, y + (2 * i + 1) * 50)
    end

    local yOffset = y + #numbers * 100

    -- Draw 1st error and return.
    for i = 1, #numbers do
        if not tonumber(numbers[i]) then
            gc:drawString("Error: Invalid input for " .. descriptions[i], x + 8, yOffset)
            return
        end
    end

    -- Draw results, no errors are encountered.
    local results = logic()
    local index = 1
    for key, value in pairs(results) do
        gc:drawString(key .. " : " .. value, x + 8, yOffset + (index - 1) * 20)
        index = index + 1
    end
end

function on.enterKey()
    if current_state > #numbers then
        current_state = #numbers + 1
        platform.window:invalidate()
        return
    end

    if numbers[current_state] ~= "" then
        current_state = current_state + 1
    end
    platform.window:invalidate()
end

function on.escapeKey()
    for i = 1, #numbers do
        numbers[i] = ""
    end
    current_state = 1
    scroll_offset = 0
    scroll_offset_x = 0
    help = false
    platform.window:invalidate()
end

function on.backspaceKey()
    if current_state > #numbers then
        return
    end
    if numbers[current_state] ~= "" then
        numbers[current_state] = string.sub(numbers[current_state], 1, -2)
    end
    platform.window:invalidate()
end

function on.deleteKey()
    on.backspaceKey()
end

function on.arrowKey(arrow) -- Add a function to handle arrow key presses
    local scroll_step = 20 -- Define the distance to scroll with each arrow key press

    if arrow == "down" then
        scroll_offset = scroll_offset + scroll_step
    elseif arrow == "up" then
        scroll_offset = scroll_offset - scroll_step
    elseif arrow == "left" then
        scroll_offset_x = scroll_offset_x - scroll_step
    elseif arrow == "right" then
        scroll_offset_x = scroll_offset_x + scroll_step
    end

    platform.window:invalidate()
end
