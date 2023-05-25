-- '2.4' is for OS 3.7
-- Our OS is 3.9 so it's good.
-- reference:
-- https://education.ti.com/html/webhelp/EG_TINspireLUA/EN/content/libraries/aa_scriptcompat/scriptcompatibility.htm#Creating
platform.apiLevel = '2.4'

local state = "first_number"
local first_number = ""
local second_number = ""

local FIRST_NUMBER_PROMPT = "First number [enter]: " 
local SECOND_NUMBER_PROMPT = "Second number [enter]: "

function on.paint(gc)
    gc:drawString(FIRST_NUMBER_PROMPT .. first_number, 8, 62)

    if state == "second_number" or state == "result" then
        gc:drawString(SECOND_NUMBER_PROMPT .. second_number, 8, 82)
    end

    if state == "result" then
        if tonumber(first_number) and tonumber(second_number) then
            local result = tonumber(first_number) + tonumber(second_number)
            gc:drawString("Addition result: " .. result, 8, 122)
        else
            gc:drawString("Error: Invalid input", 8, 122)
        end
    end
end

function on.charIn(ch)
    if (ch >= "0" and ch <= "9") or (ch == "." and ((state == "first_number" and not string.find(first_number, "%.")) or (state == "second_number" and not string.find(second_number, "%.")))) or ((ch == "+" or ch == "-") and ((state == "first_number" and first_number == "") or (state == "second_number" and second_number == ""))) then
        if (state == "first_number" and first_number == "") or (state == "second_number" and second_number == "") then
            if ch == "." then
                ch = "0."
            end
            if ch == "+" or ch == "-" then
                ch = ch
            end
        end

        if state == "first_number" then
            first_number = first_number .. ch
        elseif state == "second_number" then
            second_number = second_number .. ch
        end
        platform.window:invalidate()
    end
end

function on.enterKey()
    if state == "first_number" and first_number ~= "" then
        state = "second_number"
    elseif state == "second_number" and second_number ~= "" then
        state = "result"
    end
    platform.window:invalidate()
end

function on.escapeKey()
    first_number = ""
    second_number = ""
    state = "first_number"
    platform.window:invalidate()
end

function on.backspaceKey()
    if state == "first_number" and first_number ~= "" then
        first_number = string.sub(first_number, 1, -2)
    elseif state == "second_number" and second_number ~= "" then
        second_number = string.sub(second_number, 1, -2)
    end
    platform.window:invalidate()
end

function on.deleteKey()
    on.backspaceKey()
end
