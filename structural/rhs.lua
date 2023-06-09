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
    gc:drawRect(10, 10 - scroll_offset, 100, 100)
    gc:drawRect(30, 30 - scroll_offset, 60, 60)

    local y = 110 - scroll_offset -- Subtract the scroll offset from the y-coordinate of the text

    if current_state > #numbers then
        -- Draw result
        for i = 1, #numbers do
            gc:drawString(prompts[i] .. numbers[i], 8, y + (i - 1) * 20)
            if not tonumber(numbers[i]) then
                gc:drawString("Error: Invalid input for " .. descriptions[i], 8, y + 8 + #numbers * 20)
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
        scroll_offset = math.max(scroll_offset - scroll_step, 0)
    elseif arrow == "up" then
        local max_scroll_offset = (#numbers * 20) + 20 -- Calculate the maximum scroll offset
        scroll_offset = math.min(scroll_offset + scroll_step, max_scroll_offset)
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

    local Ah = 2 * (th * h1 / 2) -- Area of h plate
    local Ab = (tb * b1) -- Area of b plate
    local Dh = h1 / 2 / 2 -- Distance of h plate center from axis
    local Db = h1 / 2 + tb / 2 -- Distance of b plate center from axis
    local Ac = 2 * tb * th -- Area of corner
    local Dc = h1 / 2 + tb / 2

    local Zx = 2 * (Ah * Dh + Ab * Db + Ac * Dc) -- Plastic Section Modulus about x-axis

    return Zx
end
