timer = {on=false,x=199,y=1,w=58,h= 7,value=0}

gui.defaultPixelFont = "gens"
gui.defaultPixelFont = "gens"

function runTimer()

	if timer.on then
		timer.value = timer.value + 1 
		mins = math.floor(timer.value/3600)
		secs = timer.value/60-mins*60
		gui.text( timer.x, timer.y, string.format("%s:%05.2f",os.date("!%H:%M",mins*60),secs), "white" )
	end

end

function startTimer()
	bank = memory.readbyte(0x57)
	if (bank == 0x1E) then
		timer.on = true
		timer.value = 0
	end
end

function stopTimer()
	bank = memory.readbyte(0x57)
	if (bank == 0x0B) then
		timer.on = false
	end
end

function setTimerBreakpoints()
	memory.registerrun(0x806B, startTimer)	
	memory.registerrun(0xA052, stopTimer)
end

setTimerBreakpoints()

