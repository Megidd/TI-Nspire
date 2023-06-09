-- '2.4' is for OS 3.7
-- Our OS is 3.9 so it's good.
-- reference:
-- https://education.ti.com/html/webhelp/EG_TINspireLUA/EN/content/libraries/aa_scriptcompat/scriptcompatibility.htm#Creating
platform.apiLevel = '2.4'

local current_state = 1

local numbers = {"", "", "", ""}
local prompts = {"h [enter]: ", "b [enter]: ", "t of h plates [enter]: ", "t of b plates [enter]: "}
local descriptions = {"Total height", "Total width", "Thickness along height", "Thickness along width"}

local scroll_offset = 0 -- Add a variable to track the vertical scroll offset

function on.paint(gc)
    local y = scroll_offset -- Subtract the scroll offset from the y-coordinate of the text

    if current_state > #numbers then
        -- Draw result
        for i = 1, #numbers do
            gc:drawString(prompts[i] .. numbers[i], 8, y + (i - 1) * 20)
            if not tonumber(numbers[i]) then
                gc:drawString("Error: Invalid input for " .. descriptions[i], 8, y + i * 20)
                return
            end
        end
        local results = logic()
        local index = 1
        for key, value in pairs(results) do
            gc:drawString(key .. " : " .. value, 8, y + #numbers * 20 + (index - 1) * 20)
            index = index + 1
        end
    else
        for i = 1, current_state do
            gc:drawString(prompts[i] .. numbers[i], 8, y + (i - 1) * 20)
        end
    end
end

function on.charIn(ch)
    if current_state > #numbers then
        return
    end

    local acceptable = false

    if ch >= "0" and ch <= "9" then
        acceptable = true
    end

    if ch == "." then
        if not string.find(numbers[current_state], "%.") then
            acceptable = true
        end
    end

    if ch == "+" or ch == "-" then
        if numbers[current_state] == "" then
            acceptable = true
        end
    end

    if numbers[current_state] == "" or numbers[current_state] == "+" or numbers[current_state] == "-" then
        if ch == "." then
            ch = "0."
        end
    end

    if acceptable then
        numbers[current_state] = numbers[current_state] .. ch
        platform.window:invalidate()
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
    end

    platform.window:invalidate()
end

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
