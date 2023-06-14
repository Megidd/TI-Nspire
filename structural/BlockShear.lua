-- -- -- Input
local numbers = {"", "", "", "", "", "", ""}
local prompts = {"Fu: ", "Fy: ", "Ant: ", "Agv: ", "Anv: ", "Ubs: ", "Phi (0.75): "}
local descriptions = {"trivial", "trivial", "trivial", "trivial", "trivial",
                      "Where the tension stress is uniform, Ubs = 1; where the tension stress is nonuniform, Ubs = 0.5.",
                      "φ=0.75 (LRFD)"}

-- -- -- Logic

function logic()
    local results = {}

    local Fu = tonumber(numbers[1])
    local Fy = tonumber(numbers[2])
    local Ant = tonumber(numbers[3])
    local Agv = tonumber(numbers[4])
    local Anv = tonumber(numbers[5])
    local Ubs = tonumber(numbers[6])
    local Phi = tonumber(numbers[7])

    local Rn = available_strength(Fu, Anv, Ant, Ubs)
    results["Phi * Rn"] = Phi * Rn
    local Max = max_strength(Fy, Agv, Fu, Ant, Ubs)
    results["Phi * Max"] = Phi * Max
    return results
end

function available_strength(Fu, Anv, Ant, Ubs)
    local Rn = 0.60 * Fu * Anv + Ubs * Fu * Ant
    return Rn
end

function max_strength(Fy, Agv, Fu, Ant, Ubs)
    local max = 0.60 * Fy * Agv + Ubs * Fu * Ant
    return max
end

-- -- -- Common code

-- '2.4' is for OS 3.7 and our OS is 3.9 so it's good.
-- https://education.ti.com/html/webhelp/EG_TINspireLUA/EN/content/libraries/aa_scriptcompat/scriptcompatibility.htm#Creating
platform.apiLevel = '2.4'

local current_state = 1
local scroll_offset = 0 -- Add a variable to track the vertical scroll offset
local scroll_offset_x = 0
local help = false

function on.paint(gc)
    local y = scroll_offset -- Subtract the scroll offset from the y-coordinate of the text
    local x = scroll_offset_x

    -- Just show help and return.
    if help == true then
        for i = 1, #numbers do
            gc:drawString(prompts[i], x + 8, y + (2 * i + 0) * 20)
            gc:drawString(descriptions[i], x + 8, y + (2 * i + 1) * 20)
        end
        return
    end

    if current_state > #numbers then
        -- Draw result
        for i = 1, #numbers do
            gc:drawString(prompts[i] .. numbers[i], x + 8, y + (i - 1) * 20)
            if not tonumber(numbers[i]) then
                gc:drawString("Error: Invalid input for " .. descriptions[i], x + 8, y + i * 20)
                return
            end
        end
        local results = logic()
        local index = 1
        for key, value in pairs(results) do
            gc:drawString(key .. " : " .. value, x + 8, y + #numbers * 20 + (index - 1) * 20)
            index = index + 1
        end
    else
        for i = 1, current_state do
            gc:drawString(prompts[i] .. numbers[i], x + 8, y + (i - 1) * 20)
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

function on.tabKey()
    help = not help
    platform.window:invalidate()
end
