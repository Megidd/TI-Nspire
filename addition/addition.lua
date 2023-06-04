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
            if not tonumber(numbers[i]) then
                gc:drawString("Error: Invalid input for" .. descriptions[i], 8, 122)
                return
            end
        end
        local result = 0
        for i = 1, #numbers do
            result = result + tonumber(numbers[i])
        end
        for i = 1, #numbers do
            gc:drawString(prompts[i] .. numbers[i], 8, 62 + (i - 1) * 20)
        end
        gc:drawString("Addition result: " .. result, 8, 122)
    else
        for i = 1, current_state do
            gc:drawString(prompts[i] .. numbers[i], 8, 62 + (i - 1) * 20)
        end
    end
end

function on.charIn(ch)
    if (ch >= "0" and ch <= "9") or (ch == "." and ((current_state == 1 and not string.find(numbers[1], "%.")) or
        (current_state == 2 and not string.find(numbers[2], "%.")))) or
        ((ch == "+" or ch == "-") and
            ((current_state == 1 and numbers[1] == "") or (current_state == 2 and numbers[2] == ""))) then

        if (current_state == 1 and numbers[1] == "") or (current_state == 2 and numbers[2] == "") then
            if ch == "." then
                ch = "0."
            end
            if ch == "+" or ch == "-" then
                ch = ch
            end
        end

        if current_state == 1 then
            numbers[1] = numbers[1] .. ch
        elseif current_state == 2 then
            numbers[2] = numbers[2] .. ch
        end

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
