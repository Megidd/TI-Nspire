platform.apilevel = '1.0'     

menu=true
lives=3
score=0
level=1
prevscore=0
highscoresav="omnomnomnomnom"

function gamesettings()
	pacdir=1
	pacclick=0
	truemouth=15
	mouth=15
	mouthchange=0
	mouthx=1
	gonedir=0
	gtwodir=0
	gthreedir=0
	gclick=0
	wdir=0
	maze={{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,2,9,5,0,8,9,9,9,5,0,0,6,0,6,0,6,0,6,0,0,0,6,0,0,6,0,13,0,6,0,3,5,0,8,1,0,0,6,0,0,0,3,9,15,1,0,3,1,0,0,6,0,11,0,6,0,3,7,0,10,1,0,0,6,0,6,0,6,0,6,0,0,0,6,0,0,10,9,4,9,7,0,10,9,9,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,9,9,9,2,9,9,9,9,5,0,0,6,0,0,0,0,6,0,0,0,0,6,0,0,6,0,8,9,9,15,9,9,5,0,6,0,0,6,0,6,0,0,6,0,0,6,0,6,0,0,6,0,6,0,12,15,9,9,7,0,6,0,0,6,0,6,0,0,6,0,0,0,0,6,0,0,10,9,4,9,9,4,9,9,9,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,9,9,2,9,9,9,9,9,5,0,0,6,0,0,0,6,0,0,0,0,0,6,0,0,3,9,14,0,6,0,11,0,11,0,6,0,0,6,0,0,0,6,0,6,0,6,0,6,0,0,6,0,8,9,1,0,6,0,6,0,6,0,0,6,0,6,0,6,0,6,0,6,0,6,0,0,10,9,4,9,4,9,4,9,4,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,2,9,14,0,12,9,2,9,5,0,0,6,0,6,0,0,0,0,0,6,0,6,0,0,6,0,3,9,9,2,9,9,1,0,6,0,0,6,0,6,0,0,6,0,0,6,0,6,0,0,6,0,10,9,9,15,9,9,7,0,6,0,0,6,0,0,0,0,6,0,0,0,0,6,0,0,10,9,9,9,9,4,9,9,9,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,2,9,2,2,9,9,2,9,5,0,0,6,0,6,0,10,1,0,0,6,0,6,0,0,6,0,6,0,0,3,5,0,6,0,6,0,0,6,0,3,9,9,15,15,9,1,0,6,0,0,6,0,6,0,0,3,7,0,6,0,6,0,0,6,0,6,0,8,1,0,0,6,0,6,0,0,10,9,4,9,4,4,9,9,4,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,9,9,2,9,2,9,9,9,5,0,0,6,0,0,0,6,0,6,0,0,0,6,0,0,3,9,2,9,7,0,10,9,5,0,6,0,0,6,0,6,0,0,0,0,0,6,0,6,0,0,6,0,10,9,5,0,8,9,4,9,1,0,0,6,0,0,0,6,0,6,0,0,0,6,0,0,10,9,9,9,4,9,4,9,9,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,9,9,9,2,9,9,9,9,5,0,0,6,0,0,0,0,6,0,0,0,0,6,0,0,6,0,8,9,9,15,9,9,5,0,6,0,0,3,9,1,0,0,6,0,0,3,9,1,0,0,6,0,10,9,9,15,9,9,7,0,6,0,0,6,0,0,0,0,6,0,0,0,0,6,0,0,10,9,9,9,9,4,9,9,9,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,9,9,2,2,2,9,9,9,5,0,0,6,0,0,0,3,4,1,0,0,0,6,0,0,6,0,11,0,6,0,6,0,11,0,6,0,0,3,2,4,2,1,0,3,2,4,2,1,0,0,10,1,0,10,4,9,4,7,0,3,7,0,0,0,6,0,0,0,0,0,0,0,6,0,0,0,0,10,9,9,9,9,9,9,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,9,9,9,2,9,2,9,9,9,14,0,0,0,0,0,0,6,0,6,0,0,0,0,0,0,8,9,2,9,4,9,4,9,2,9,5,0,0,6,0,6,0,0,0,0,0,6,0,6,0,0,10,9,4,9,2,9,2,9,4,9,7,0,0,0,0,0,0,6,0,6,0,0,0,0,0,0,12,9,9,9,4,9,4,9,9,9,14,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,2,9,2,9,2,9,2,9,5,0,0,6,0,6,0,6,0,6,0,6,0,6,0,0,6,0,6,0,3,9,1,0,6,0,6,0,0,6,0,3,9,1,0,3,9,1,0,6,0,0,6,0,6,0,3,9,1,0,6,0,6,0,0,6,0,6,0,6,0,6,0,6,0,6,0,0,10,9,4,9,4,9,4,9,4,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0}}
	leveldata={{13,9,23,51,10,2},{13,9,23,51,10,2},{13,9,23,50,10,2},{13,9,23,51,10,2},{13,9,23,53,10,2},{13,9,23,52,10,2},{13,9,23,53,10,2},{13,9,23,52,10,2},{13,9,23,52,10,2},{13,9,23,56,10,2}}
	currmaze=maze[level]
	mazewidth=leveldata[level][1]
	mazeheight=leveldata[level][2]
	blockwidth=leveldata[level][3]
	levelgoal=leveldata[level][4]+prevscore
	x=leveldata[level][5]
	y=leveldata[level][6]
	local l=blockwidth
	chardata={{59,6,4,3,3,3,5,10,4,43,69,63},{85,6,6,3,4,6,4,9,4,56,59,62},{43,3,3,6,7,8,7,10,7,98,100,102},{85,6,6,3,4,6,4,9,4,56,59,62},{32,5,2,7,3,7,5,5,6,47,73,84},{45,5,3,7,3,5,5,7,5,47,71,73},{33,6,2,2,4,6,6,10,4,55,85,63},{33,6,2,3,3,9,3,6,5,43,49,72},{20,6,1,2,5,6,5,10,5,68,72,76},{20,6,1,4,4,8,4,6,5,57,61,72}}
	pacm=chardata[level][1]
	pacx=chardata[level][2]*l+x
	pacy=chardata[level][3]*l+y
	gonex=chardata[level][4]*l+x
	goney=chardata[level][5]*l+y
	gtwox=chardata[level][6]*l+x
	gtwoy=chardata[level][7]*l+y
	gthreex=chardata[level][8]*l+x
	gthreey=chardata[level][9]*l+y
	gonem=chardata[level][10]
	gtwom=chardata[level][11]
	gthreem=chardata[level][12]
	numlevels=table.maxn(leveldata)
	start=false
	lost=false
	levelup=false
	won=false
	game=true
end

function on.create()
	button=0
	gamesettings()
	dots={{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,2,9,5,0,8,9,9,9,5,0,0,6,0,6,0,6,0,6,0,0,0,6,0,0,6,0,13,0,6,0,3,5,0,8,1,0,0,6,0,0,0,3,9,15,1,0,3,1,0,0,6,0,11,0,6,0,3,7,0,10,1,0,0,6,0,6,0,6,0,6,0,0,0,6,0,0,10,9,4,9,7,0,10,9,9,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,9,9,9,2,9,9,9,9,5,0,0,6,0,0,0,0,6,0,0,0,0,6,0,0,6,0,8,9,9,15,9,9,5,0,6,0,0,6,0,6,0,0,6,0,0,6,0,6,0,0,6,0,6,0,12,15,9,9,7,0,6,0,0,6,0,6,0,0,6,0,0,0,0,6,0,0,10,9,4,9,9,4,9,9,9,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,9,9,2,9,9,9,9,9,5,0,0,6,0,0,0,6,0,0,0,0,0,6,0,0,3,9,14,0,6,0,11,0,11,0,6,0,0,6,0,0,0,6,0,6,0,6,0,6,0,0,6,0,8,9,1,0,6,0,6,0,6,0,0,6,0,6,0,6,0,6,0,6,0,6,0,0,10,9,4,9,4,9,4,9,4,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,2,9,14,0,12,9,2,9,5,0,0,6,0,6,0,0,0,0,0,6,0,6,0,0,6,0,3,9,9,2,9,9,1,0,6,0,0,6,0,6,0,0,6,0,0,6,0,6,0,0,6,0,10,9,9,15,9,9,7,0,6,0,0,6,0,0,0,0,6,0,0,0,0,6,0,0,10,9,9,9,9,4,9,9,9,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,2,9,2,2,9,9,2,9,5,0,0,6,0,6,0,10,1,0,0,6,0,6,0,0,6,0,6,0,0,3,5,0,6,0,6,0,0,6,0,3,9,9,15,15,9,1,0,6,0,0,6,0,6,0,0,3,7,0,6,0,6,0,0,6,0,6,0,8,1,0,0,6,0,6,0,0,10,9,4,9,4,4,9,9,4,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,9,9,2,9,2,9,9,9,5,0,0,6,0,0,0,6,0,6,0,0,0,6,0,0,3,9,2,9,7,0,10,9,5,0,6,0,0,6,0,6,0,0,0,0,0,6,0,6,0,0,6,0,10,9,5,0,8,9,4,9,1,0,0,6,0,0,0,6,0,6,0,0,0,6,0,0,10,9,9,9,4,9,4,9,9,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,9,9,9,2,9,9,9,9,5,0,0,6,0,0,0,0,6,0,0,0,0,6,0,0,6,0,8,9,9,15,9,9,5,0,6,0,0,3,9,1,0,0,6,0,0,3,9,1,0,0,6,0,10,9,9,15,9,9,7,0,6,0,0,6,0,0,0,0,6,0,0,0,0,6,0,0,10,9,9,9,9,4,9,9,9,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,9,9,2,2,2,9,9,9,5,0,0,6,0,0,0,3,4,1,0,0,0,6,0,0,6,0,11,0,6,0,6,0,11,0,6,0,0,3,2,4,2,1,0,3,2,4,2,1,0,0,10,1,0,10,4,9,4,7,0,3,7,0,0,0,6,0,0,0,0,0,0,0,6,0,0,0,0,10,9,9,9,9,9,9,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,9,9,9,2,9,2,9,9,9,14,0,0,0,0,0,0,6,0,6,0,0,0,0,0,0,8,9,2,9,4,9,4,9,2,9,5,0,0,6,0,6,0,0,0,0,0,6,0,6,0,0,10,9,4,9,2,9,2,9,4,9,7,0,0,0,0,0,0,6,0,6,0,0,0,0,0,0,12,9,9,9,4,9,4,9,9,9,14,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,9,2,9,2,9,2,9,2,9,5,0,0,6,0,6,0,6,0,6,0,6,0,6,0,0,6,0,6,0,3,9,1,0,6,0,6,0,0,6,0,3,9,1,0,3,9,1,0,6,0,0,6,0,6,0,3,9,1,0,6,0,6,0,0,6,0,6,0,6,0,6,0,6,0,6,0,0,10,9,4,9,4,9,4,9,4,9,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0}}
	high=var.recall(highscoresav) or 0
end

function on.enterKey()
	if not lost and not won and not levelup and not menu then
		start=true
		platform.window:invalidate()
	end
	if lost then
		if score>high then
			high=score
			var.store(highscoresav,high)
			document.markChanged()
		end
		score=0
		level=1
		lives=3
		prevscore=0
		on.create()
		platform.window:invalidate()
	end
	if levelup then
		level=level+1
		lives=lives+1
		on.create()
		platform.window:invalidate()
	end
	if won then
		score=score+50*lives
		if score>high then
			high=score
			var.store(highscoresav)
			document.markChanged()
		end
		score=0
		level=1
		lives=3
		prevscore=0
		on.create()
		platform.window:invalidate()
	end
	if menu then
		menu=false
		on.create()
		platform.window:invalidate()
	end
end

function on.escapeKey()
	start=false
	platform.window:invalidate()
end

function on.charIn(ch)
	if ch=="8" then
		on.arrowKey("up")
	elseif ch=="4" then
		on.arrowKey("left")
	elseif ch=="6" then
		on.arrowKey("right")
	elseif ch=="2" then
		on.arrowKey("down")
	elseif ch=="5" then
		on.escapeKey()
	end
end

function on.paint(gc)
	if game then
		pacdraw(gc)
		drawghosts(gc)
		gc:setColorRGB(255,255,255)
		gc:drawString("Score: "..score,x+2,y,"top")
		gc:drawString("Lives: "..lives,x+2,212-y-gc:getStringHeight("Lives: "),"top")
		if start then
			timer.start(.01)
		end
		if lost then
			drawform(gc,100,150,"GAME OVER :(","You lost all your lives!",50,gc:getStringHeight("OK"),"OK")
		end
		if levelup then
			drawform(gc,100,150,"LEVEL UP! :)","Level Complete!",gc:getStringWidth("Next")+10,gc:getStringHeight("Next"),"Next")
		end
		if won then
			drawform(gc,100,150,"YOU WON! :D","All levels Complete!",gc:getStringWidth("Done")+10,gc:getStringHeight("Done"),"Done")
		end
	end
	if menu then
		drawmenu(gc)
	end
	gc:setColorRGB(0,0,0)
	gc:drawRect(0,250,318,50)
	gc:drawString("Enter Key",(318-gc:getStringWidth("Enter Key"))/2,(50-gc:getStringHeight("Enter Key"))/2+250,"top")
	gc:drawRect(340,250,50,50)
	gc:drawRect(390,200,50,50)
	gc:drawRect(440,250,50,50)
	gc:drawRect(390,300,50,50)
end

function on.mouseDown(x,y)
	if x>0 and x<318 and y>250 and y<300 then
		on.enterKey()
	end
	if x>340 and x<490 then
		if x<390 and y>250 and y<300 then
			on.arrowKey("left")
		elseif x>390 and x<440 then
			if y>200 and y<250 then
				on.arrowKey("up")
			elseif y>300 and y<350 then
				on.arrowKey("down")
			end
		elseif x>440 and y>250 and y<300 then
			on.arrowKey("right")
		end
	end
end

function refresh()
	if not menu and not lost and not levelup and not won and not collidea and not collideb and not collidec then
		if math.floor(gclick/2)==gclick/2 then
			platform.window:invalidate(pacx-3,pacy-3,blockwidth+6,blockwidth+6)
			platform.window:invalidate(gonex-3,goney-3,blockwidth+6,blockwidth+6)
		else
			platform.window:invalidate(gtwox-3,gtwoy-3,blockwidth+6,blockwidth+6)
			platform.window:invalidate(gthreex-3,gthreey-3,blockwidth+6,blockwidth+6)
			platform.window:invalidate(x,y,blockwidth,blockwidth)
		end
	else
		platform.window:invalidate()
	end
end

function on.timer()
	checkg1()
	checkg2()
	checkg3()
	if not collidea and not collideb and not collidec then
		pactimer()
		ghosttimer()
	else
		if truemouth~=150 then
			truemouth=truemouth+1
		else
			if lives~=0 then
				gamesettings()
				lives=lives-1
			else
				lost=true
				start=false
			end
		end
	end
	timer.stop()
	refresh()
end

function on.arrowKey(key)
	if not menu then
		if key=="left" then
			if pacclick~=0 then
				wdir=3
			else
				pacdir=3
			end
			refresh()
		elseif key=="right" then
			if pacclick~=0 then
				wdir=1
			else
				pacdir=1
			end
			refresh()
		elseif key=="up" then
			if pacclick~=0 then
				wdir=2
			else
				pacdir=2
			end
			refresh()
		elseif key=="down" then
			if pacclick~=0 then
				wdir=4
			else
				pacdir=4
			end
			refresh()
		end
	end
end
function pacdraw(gc)
	gc:setColorRGB(0,0,0)
	for a=1,mazeheight do
		for b=1,mazewidth do
			local m=dots[level][mazewidth*(a-1)+b]
			if m~=0 then
				gc:fillArc(blockwidth*(b-.6)+x,blockwidth*(a-.6)+y,.2*blockwidth,.2*blockwidth,0,360)
			end
		end
	end
	for a=1,mazeheight do
		for b=1,mazewidth do
			local m=currmaze[mazewidth*(a-1)+b]
			if m==0 then
				gc:fillRect(blockwidth*(b-1)+x,blockwidth*(a-1)+y,blockwidth,blockwidth)
			end
		end
	end
	gc:setColorRGB(255,255,0)
	gc:fillArc(pacx,pacy,blockwidth,blockwidth,30+truemouth+90*pacdir-90,300-2*truemouth)
	gc:setColorRGB(0,0,0)
	gc:drawArc(pacx,pacy,blockwidth,blockwidth,30+truemouth+90*pacdir-90,300-2*truemouth)
	if pacdir==1 or pacdir==3 then
		gc:drawLine(pacx+blockwidth/2,pacy+blockwidth/2,pacx+blockwidth/2+(blockwidth/2*math.cos(math.pi*(30+truemouth+90*(pacdir-1))/180)),pacy+blockwidth/2-(blockwidth/2*math.sin(math.pi*(30+truemouth+90*(pacdir-1))/180)))
		gc:drawLine(pacx+blockwidth/2,pacy+blockwidth/2,pacx+blockwidth/2+(blockwidth/2*math.cos(math.pi*(30+truemouth+90*(pacdir-1))/180)),pacy+blockwidth/2+(blockwidth/2*math.sin(math.pi*(30+truemouth+90*(pacdir-1))/180)))
	else
		gc:drawLine(pacx+blockwidth/2,pacy+blockwidth/2,pacx+blockwidth/2-(blockwidth/2*math.cos(math.pi*(30+truemouth+90*(pacdir-1))/180)),pacy+blockwidth/2-(blockwidth/2*math.sin(math.pi*(30+truemouth+90*(pacdir-1))/180)))
		gc:drawLine(pacx+blockwidth/2,pacy+blockwidth/2,pacx+blockwidth/2+(blockwidth/2*math.cos(math.pi*(30+truemouth+90*(pacdir-1))/180)),pacy+blockwidth/2-(blockwidth/2*math.sin(math.pi*(30+truemouth+90*(pacdir-1))/180)))
	end
end

function drawghosts(gc)
	gc:setColorRGB(255,0,0)
	gc:fillArc(gonex,goney,blockwidth,blockwidth,0,180)
	gc:fillPolygon({gonex,goney+blockwidth/2,gonex,goney+blockwidth,gonex+.2*blockwidth,goney+.8*blockwidth,gonex+.4*blockwidth,goney+blockwidth,gonex+.45*blockwidth,goney+blockwidth,gonex+.45*blockwidth,goney+.8*blockwidth,gonex+.55*blockwidth,goney+.8*blockwidth,gonex+.55*blockwidth,goney+blockwidth,gonex+.6*blockwidth,goney+blockwidth,gonex+.8*blockwidth,goney+.8*blockwidth,gonex+blockwidth,goney+blockwidth,gonex+blockwidth,goney+.5*blockwidth,gonex,goney+.5*blockwidth})
	gc:setColorRGB(255,255,255)
	gc:fillArc(gonex+.25*blockwidth,goney+.25*blockwidth,.25*blockwidth,.35*blockwidth,0,360)
	gc:fillArc(gonex+.6*blockwidth,goney+.25*blockwidth,.25*blockwidth,.35*blockwidth,0,360)
	gc:setColorRGB(0,0,255)
	gc:fillArc(gonex+.38*blockwidth,goney+.35*blockwidth,.1*blockwidth,.15*blockwidth,0,360)
	gc:fillArc(gonex+.75*blockwidth,goney+.35*blockwidth,.1*blockwidth,.15*blockwidth,0,360)
	gc:setColorRGB(0,255,255)
	gc:fillArc(gtwox,gtwoy,blockwidth,blockwidth,0,180)
	gc:fillPolygon({gtwox,gtwoy+blockwidth/2,gtwox,gtwoy+blockwidth,gtwox+.2*blockwidth,gtwoy+.8*blockwidth,gtwox+.4*blockwidth,gtwoy+blockwidth,gtwox+.45*blockwidth,gtwoy+blockwidth,gtwox+.45*blockwidth,gtwoy+.8*blockwidth,gtwox+.55*blockwidth,gtwoy+.8*blockwidth,gtwox+.55*blockwidth,gtwoy+blockwidth,gtwox+.6*blockwidth,gtwoy+blockwidth,gtwox+.8*blockwidth,gtwoy+.8*blockwidth,gtwox+blockwidth,gtwoy+blockwidth,gtwox+blockwidth,gtwoy+.5*blockwidth,gtwox,gtwoy+.5*blockwidth})
	gc:setColorRGB(255,255,255)
	gc:fillArc(gtwox+.25*blockwidth,gtwoy+.25*blockwidth,.25*blockwidth,.35*blockwidth,0,360)
	gc:fillArc(gtwox+.6*blockwidth,gtwoy+.25*blockwidth,.25*blockwidth,.35*blockwidth,0,360)
	gc:setColorRGB(0,0,255)
	gc:fillArc(gtwox+.38*blockwidth,gtwoy+.35*blockwidth,.1*blockwidth,.15*blockwidth,0,360)
	gc:fillArc(gtwox+.75*blockwidth,gtwoy+.35*blockwidth,.1*blockwidth,.15*blockwidth,0,360)
	gc:setColorRGB(255,128,255)
	gc:fillArc(gthreex,gthreey,blockwidth,blockwidth,0,180)
	gc:fillPolygon({gthreex,gthreey+blockwidth/2,gthreex,gthreey+blockwidth,gthreex+.2*blockwidth,gthreey+.8*blockwidth,gthreex+.4*blockwidth,gthreey+blockwidth,gthreex+.45*blockwidth,gthreey+blockwidth,gthreex+.45*blockwidth,gthreey+.8*blockwidth,gthreex+.55*blockwidth,gthreey+.8*blockwidth,gthreex+.55*blockwidth,gthreey+blockwidth,gthreex+.6*blockwidth,gthreey+blockwidth,gthreex+.8*blockwidth,gthreey+.8*blockwidth,gthreex+blockwidth,gthreey+blockwidth,gthreex+blockwidth,gthreey+.5*blockwidth,gthreex,gthreey+.5*blockwidth})
	gc:setColorRGB(255,255,255)
	gc:fillArc(gthreex+.25*blockwidth,gthreey+.25*blockwidth,.25*blockwidth,.35*blockwidth,0,360)
	gc:fillArc(gthreex+.6*blockwidth,gthreey+.25*blockwidth,.25*blockwidth,.35*blockwidth,0,360)
	gc:setColorRGB(0,0,255)
	gc:fillArc(gthreex+.38*blockwidth,gthreey+.35*blockwidth,.1*blockwidth,.15*blockwidth,0,360)
	gc:fillArc(gthreex+.75*blockwidth,gthreey+.35*blockwidth,.1*blockwidth,.15*blockwidth,0,360)
end

function drawform(gc,height,width,title,text,buttonwidth,buttonheight,buttontext)
	gc:setColorRGB(192,192,192)
	gc:fillRect((318-width)/2,(212-height)/2,width,height)
	gc:setColorRGB(0,0,0)
	gc:fillRect((318-width)/2,(212-height)/2,width,gc:getStringHeight(title))
	gc:drawString(text,(318-gc:getStringWidth(text))/2,(212-gc:getStringHeight(text))/2,"top")
	gc:drawRect((318-buttonwidth)/2,106+.5*height-buttonheight-1,buttonwidth,buttonheight)
	gc:drawString(buttontext,(318-gc:getStringWidth(buttontext))/2,106+.5*height-buttonheight-1,"top")
	gc:setColorRGB(255,255,255)
	gc:drawString(title,(318-width)/2,(212-height)/2,"top")
end

function drawmenu(gc)
	gc:setColorRGB(0,0,0)
	gc:fillRect(0,0,318,212)
	gc:setColorRGB(255,255,255)
	gc:fillPolygon({60,68,60,20,82,20,84,22,84,48,82,50,67,50,67,68,60,68})
	gc:setColorRGB(0,0,0)
	gc:fillRect(67,27,9,16)
	gc:setColorRGB(255,255,255)
	gc:fillPolygon({88,68,96,20,104,20,112,68,88,68})
	gc:setColorRGB(0,0,0)
	gc:fillPolygon({95,68,96,60,104,60,105,68,95,68})
	gc:fillPolygon({97,52,100,31,103,52,97,52})
	gc:setColorRGB(255,255,0)
	gc:fillArc(116,20,48,48,30,300)
	gc:setColorRGB(255,255,255)
	gc:fillPolygon({168,68,168,20,175,20,183,47,191,20,198,20,198,68,191,68,191,40,185,63,181,63,175,40,175,68,168,68})
	gc:fillPolygon({201,68,210,20,218,20,227,68,219,68,218,60,210,60,209,68,201,68})
	gc:setColorRGB(0,0,0)
	gc:fillPolygon({211,52,214,31,217,52,211,52})
	gc:setColorRGB(255,255,255)
	gc:fillPolygon({230,68,230,20,237,20,247,48,247,20,254,20,254,68,247,68,237,39,237,68,230,68})
	gonex=104
	goney=186
	gtwox=134
	gtwoy=186
	gthreex=164
	gthreey=186
	blockwidth=20
	drawghosts(gc)
	gc:setColorRGB(255,255,0)
	gc:fillArc(194,186,20,20,30,300)
	gc:setColorRGB(255,255,255)
	for f=0,17 do
		gc:fillArc(214+6*f,195,4,4,0,360)
	end
	gc:setFont("sansserif","b",14)
	gc:drawString("New Game",(318-gc:getStringWidth("New Game"))/2,100,"top")
	if platform.isColorDisplay() then
		gc:setColorRGB(0,0,255)
	else
		gc:setColorRGB(255,255,255)
	end
	gc:drawLine(109,95,209,95)
	gc:drawLine(109,95+32,209,95+32)
	gc:drawArc(93,95,32,32,90,180)
	gc:drawArc(193,95,32,32,270,180)
	gc:drawString("High Score: "..high,(318-gc:getStringWidth("High Score: "..high))/2,132,"top")
end
function checkg1()
	if pacx>gonex-blockwidth+5 and pacx<gonex+blockwidth-5 and pacy>goney-blockwidth+5 and pacy<goney+blockwidth-5 then
		collidea=true
	else
		collidea=false
	end
end

function checkg2()
	if pacx>gtwox-blockwidth+5 and pacx<gtwox+blockwidth-5 and pacy>gtwoy-blockwidth+5 and pacy<gtwoy+blockwidth-5 then
		collideb=true
	else
		collideb=false
	end
end

function checkg3()
	if pacx>gthreex-blockwidth+5 and pacx<gthreex+blockwidth-5 and pacy>gthreey-blockwidth+5 and pacy<gthreey+blockwidth-5 then
		collidec=true
	else
		collidec=false
	end
end
function pacmove()
	if pacdir==1 then
		if currmaze[pacm+1]~=0 then
			pacx=pacx+1
			pacclick=pacclick+1
		end
	elseif pacdir==2 then
		if currmaze[pacm-mazewidth]~=0 then
			pacy=pacy-1
			pacclick=pacclick+1
		end
	elseif pacdir==3 then
		if currmaze[pacm-1]~=0 then
			pacx=pacx-1
			pacclick=pacclick+1
		end
	elseif pacdir==4 then
		if currmaze[pacm+mazewidth]~=0 then
			pacy=pacy+1
			pacclick=pacclick+1
		end
	end
end

function pacmchange()
	if pacdir==1 then
		pacm=pacm+1
	elseif pacdir==2 then
		pacm=pacm-mazewidth
	elseif pacdir==3 then
		pacm=pacm-1
	elseif pacdir==4 then
		pacm=pacm+mazewidth
	end
end

function gonemove()
	if gonedir==1 then
		if currmaze[gonem+1]~=0 then
			gonex=gonex+1
		end
	elseif gonedir==2 then
		if currmaze[gonem-mazewidth]~=0 then
			goney=goney-1
		end
	elseif gonedir==3 then
		if currmaze[gonem-1]~=0 then
			gonex=gonex-1
		end
	elseif gonedir==4 then
		if currmaze[gonem+mazewidth]~=0 then
			goney=goney+1
		end
	end
end

function gonemchange()
	if gonedir==1 then
		gonem=gonem+1
	elseif gonedir==2 then
		gonem=gonem-mazewidth
	elseif gonedir==3 then
		gonem=gonem-1
	elseif gonedir==4 then
		gonem=gonem+mazewidth
	end
	gonech={}
	local ab=currmaze[gonem]
	if ab==2 or ab==3 or ab==4 or ab==8 or ab==9 or ab==10 or ab==15 then
		if gonedir~=3 then
			table.insert(gonech,1)
		end
	end
	if ab==1 or ab==3 or ab==4 or ab==6 or ab==7 or ab==10 or ab==15 then
		if gonedir~=4 then
			table.insert(gonech,2)
		end
	end
	if ab==1 or ab==2 or ab==4 or ab==5 or ab==7 or ab==9 or ab==15 then
		if gonedir~=1 then
			table.insert(gonech,3)
		end
	end
	if ab==1 or ab==2 or ab==3 or ab==5 or ab==6 or ab==8 or ab==15 then
		if gonedir~=2 then
			table.insert(gonech,4)
		end
	end
	if ab==11 then
		table.insert(gonech,4)
	end
	if ab==12 then
		table.insert(gonech,1)
	end
	if ab==13 then
		table.insert(gonech,2)
	end
	if ab==14 then
		table.insert(gonech,3)
	end
	gonedir=gonech[math.random(table.maxn(gonech))]
end

function gtwomove()
	if gtwodir==1 then
		if currmaze[gtwom+1]~=0 then
			gtwox=gtwox+1
		end
	elseif gtwodir==2 then
		if currmaze[gtwom-mazewidth]~=0 then
			gtwoy=gtwoy-1
		end
	elseif gtwodir==3 then
		if currmaze[gtwom-1]~=0 then
			gtwox=gtwox-1
		end
	elseif gtwodir==4 then
		if currmaze[gtwom+mazewidth]~=0 then
			gtwoy=gtwoy+1
		end
	end
end

function gtwomchange()
	if gtwodir==1 then
		gtwom=gtwom+1
	elseif gtwodir==2 then
		gtwom=gtwom-mazewidth
	elseif gtwodir==3 then
		gtwom=gtwom-1
	elseif gtwodir==4 then
		gtwom=gtwom+mazewidth
	end
	gtwoch={}
	local ab=currmaze[gtwom]
	if ab==2 or ab==3 or ab==4 or ab==8 or ab==9 or ab==10 or ab==15 then
		if gtwodir~=3 then
			table.insert(gtwoch,1)
		end
	end
	if ab==1 or ab==3 or ab==4 or ab==6 or ab==7 or ab==10 or ab==15 then
		if gtwodir~=4 then
			table.insert(gtwoch,2)
		end
	end
	if ab==1 or ab==2 or ab==4 or ab==5 or ab==7 or ab==9 or ab==15 then
		if gtwodir~=1 then
			table.insert(gtwoch,3)
		end
	end
	if ab==1 or ab==2 or ab==3 or ab==5 or ab==6 or ab==8 or ab==15 then
		if gtwodir~=2 then
			table.insert(gtwoch,4)
		end
	end
	if ab==11 then
		table.insert(gtwoch,4)
	end
	if ab==12 then
		table.insert(gtwoch,1)
	end
	if ab==13 then
		table.insert(gtwoch,2)
	end
	if ab==14 then
		table.insert(gtwoch,3)
	end
	gtwodir=gtwoch[math.random(table.maxn(gtwoch))]
end

function gthreemove()
	if gthreedir==1 then
		if currmaze[gthreem+1]~=0 then
			gthreex=gthreex+1
		end
	elseif gthreedir==2 then
		if currmaze[gthreem-mazewidth]~=0 then
			gthreey=gthreey-1
		end
	elseif gthreedir==3 then
		if currmaze[gthreem-1]~=0 then
			gthreex=gthreex-1
		end
	elseif gthreedir==4 then
		if currmaze[gthreem+mazewidth]~=0 then
			gthreey=gthreey+1
		end
	end
end

function gthreemchange()
	if gthreedir==1 then
		gthreem=gthreem+1
	elseif gthreedir==2 then
		gthreem=gthreem-mazewidth
	elseif gthreedir==3 then
		gthreem=gthreem-1
	elseif gthreedir==4 then
		gthreem=gthreem+mazewidth
	end
	gthreech={}
	local ab=currmaze[gthreem]
	if ab==2 or ab==3 or ab==4 or ab==8 or ab==9 or ab==10 or ab==15 then
		if gthreedir~=3 then
			table.insert(gthreech,1)
		end
	end
	if ab==1 or ab==3 or ab==4 or ab==6 or ab==7 or ab==10 or ab==15 then
		if gthreedir~=4 then
			table.insert(gthreech,2)
		end
	end
	if ab==1 or ab==2 or ab==4 or ab==5 or ab==7 or ab==9 or ab==15 then
		if gthreedir~=1 then
			table.insert(gthreech,3)
		end
	end
	if ab==1 or ab==2 or ab==3 or ab==5 or ab==6 or ab==8 or ab==15 then
		if gthreedir~=2 then
			table.insert(gthreech,4)
		end
	end
	if ab==11 then
		table.insert(gthreech,4)
	end
	if ab==12 then
		table.insert(gthreech,1)
	end
	if ab==13 then
		table.insert(gthreech,2)
	end
	if ab==14 then
		table.insert(gthreech,3)
	end
	gthreedir=gthreech[math.random(table.maxn(gthreech))]
end
function pactimer()
	if pacclick==blockwidth then
		pacclick=0
		pacmchange()
		if dots[level][pacm]~=0 then
			score=score+1
		end
		dots[level][pacm]=0
		if wdir~=0 then
			pacdir=wdir
			wdir=0
		end
		if score==levelgoal then
			if level~=numlevels then
				levelup=true
				start=false
				prevscore=score
			else
				won=true
				start=false
			end
		end
	end
	if mouthchange==30 then
		mouthx=0-mouthx
		mouthchange=0
	end
	truemouth=truemouth-mouthx
	mouth=truemouth+90*(pacdir-1)
	mouthchange=mouthchange+1
	pacmove()
end

function ghosttimer()
	if gclick==blockwidth or gclick==0 then
		gclick=0
		gonemchange()
		gtwomchange()
		gthreemchange()
	end
	gonemove()
	gtwomove()
	gthreemove()
	gclick=gclick+1
end
