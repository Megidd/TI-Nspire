-- '2.4' is for OS 3.7
-- Our OS is 3.9 so it's good.
-- reference:
-- https://education.ti.com/html/webhelp/EG_TINspireLUA/EN/content/libraries/aa_scriptcompat/scriptcompatibility.htm#Creating
platform.apiLevel = '2.4'

local current_state = 1

local numbers = {"", ""}
local prompts = {"First number [enter]: ", "Second number [enter]: "}
local descriptions = {"1st number", "2nd number"}

function on.paint(gc)
    if current_state > #numbers then
        -- Draw result
        for i = 1, #numbers do
            gc:drawString(prompts[i] .. numbers[i], 8, 8 + (i - 1) * 20)
            if not tonumber(numbers[i]) then
                gc:drawString("Error: Invalid input for " .. descriptions[i], 8, 8 + #numbers * 20)
                return
            end
        end
        local result = 0
        for i = 1, #numbers do
            result = result + tonumber(numbers[i])
        end
        gc:drawString("Addition result: " .. result, 8, 8 + #numbers * 20)
    else
        for i = 1, current_state do
            gc:drawString(prompts[i] .. numbers[i], 8, 8 + (i - 1) * 20)
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
