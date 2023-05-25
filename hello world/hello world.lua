-- '2.4' is for OS 3.7
-- Our OS is 3.9 so it's good.
-- reference:
-- https://education.ti.com/html/webhelp/EG_TINspireLUA/EN/content/libraries/aa_scriptcompat/scriptcompatibility.htm#Creating
platform.apiLevel = '2.4'

myimage=image.new(_R.IMG.baby)

function on.paint(gc)
    gc:drawString("Hello world :)", 158, 62)
    gc:drawString('Saturday', 158, 102)
    gc:drawString('Oct 29 2022', 158, 122)
    gc:drawString('9~10AM', 158, 142)
    
    gc:drawImage(myimage, 88, 48)
end