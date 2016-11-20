display.setStatusBar (display.HiddenStatusBar)

require ("physics")

physics.start()
physics.setGravity(0,0)

local pelotas = 3
local bloques = 0

local Interfaz = display.newText ("Pelotas: "..pelotas , 220,30,"arial",14)

local paredArriba = display.newRect(160,5,320,10)
local paredAbajo = display.newRect(160,475,320,10)
local paredIzquierda = display.newRect(5,240,10,480)
local paredDerecha = display.newRect(315,240,10,480)

paredAbajo.isVisible = false
paredAbajo.tipo = "fondo"

physics.addBody(paredArriba,"static",{friction=0,bounce = 1})
physics.addBody(paredAbajo,"static",{friction=0,bounce = 1})
physics.addBody(paredIzquierda,"static",{friction=0,bounce = 1})
physics.addBody(paredDerecha,"static",{friction=0,bounce = 1})

local tBloque = {alto = 20, ancho = 40}
local cIniciales = {x = 40, y = 50}

for linea = 0,5 -1 do
	for columna = 0,7 -1 do
		local bloque = display.newRect(cIniciales.x + (columna*tBloque.ancho),cIniciales.y + (linea*tBloque.alto),tBloque.ancho,tBloque.alto)
		bloque:setFillColor( math.random(0,255)/255 , math.random(0,255)/255 , math.random(0,255)/255)
		bloque.tipo = "bloque"
		physics.addBody(bloque,"static",{friction = 1, bounce = 1})
		bloques = bloques +1
		print (bloques)
	end
end

local function crearPelota()

pelota = display.newCircle (160,240,10)
physics.addBody(pelota,"dynamic", {friction = 0, bounce = 1, radius = 10})

pelota.collision = function (self,choque)
	
	if choque.phase == "ended" then
	
		if choque.other.tipo == "bloque" then
			choque.other:removeSelf()
			bloques = bloques - 1
		end
		
		if choque.other.tipo == "fondo" then
			
			self:removeSelf()
			pelotas = pelotas - 1
			Interfaz.text = "Pelotas: "..pelotas
			
			local function nuevaPelota()
				if pelotas > 0 then
					crearPelota()
					pelota:setLinearVelocity (75,150)
				else
					Interfaz.text = "PERDISTE!!!"
				end
			end
			timer.performWithDelay(500, nuevaPelota,1)
		end
	end
end

pelota:addEventListener("collision",pelota)
end

crearPelota()
pelota:setLinearVelocity(75,150)

local barra = display.newRoundedRect (160,430,100,10,5)
physics.addBody (barra,"static",{friction = 2, bounce = 1})

local function moverBarra (evento)
	barra.x = evento.x
	
end

Runtime:addEventListener ("touch",moverBarra)

local function perder()

if bloques == 0 then
	Interfaz.text = "GANASTE!!!"
end

end

Runtime:addEventListener ("enterFrame", perder) 




			
			
			
		














