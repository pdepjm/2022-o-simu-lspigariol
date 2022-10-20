class Mision {
	
	var formaDePremiar = normal

	method superada() = self.destrezaSuficiente() || self.personajeTieneEstrategia()
	
	method destrezaSuficiente()
	
	method personajeTieneEstrategia() 
	
	method realizar() {
		self.validarRealizacion()
		self.repartirCopas()
	}
	method validarRealizacion() {
		if(!self.puedeRealizarse())
			throw new Exception(message = "Misión no puede comenzar")
	}
	
	method puedeRealizarse()
	method repartirCopas() 
		
	method cantCopas() = formaDePremiar.cantCopasFinal(self)
	method sumarOrestar() = if(self.superada()) 1 else -1
	
}

class MisionIndividual inherits Mision {
	
	var personaje
	var dificultad
	
	override method puedeRealizarse() = personaje.copas() >= 10
	
	override method destrezaSuficiente() = dificultad < personaje.destreza()

	override method personajeTieneEstrategia() = personaje.tieneEstrategia()
	
	override method repartirCopas() {
		personaje.darCopas(self.cantCopas()*self.sumarOrestar())
	}
		  
	method cantCopasBase() = dificultad * 2
		
	method cantParticipantes() = 1
	
	method personaje(pers) {
		personaje = pers
	}
}


object bonus {
	method cantCopasFinal(mision) = mision.cantCopasBase() + mision.cantParticipantes()
}

class Boost {
	var property multiplicador 
	method cantCopasFinal(mision) = mision.cantCopasBase() * multiplicador
}

object normal {
	method cantCopasFinal(mision) = mision.cantCopasBase()
}


class MisionEquipo inherits Mision {
	
	var personajes = []
	
	
	override method repartirCopas() {
		personajes.forEach{p=>p.darCopas(self.cantCopas()*self.sumarOrestar())}
	}
		
	method cantCopasBase() = 50/ personajes.size()
	
	override method destrezaSuficiente() = personajes.all{p=>p.destreza()>400} 

	override method personajeTieneEstrategia() = self.personajesConEstrategia() > self.mitadPersonajes() 
	
	method personajesConEstrategia() = personajes.count{p=>p.tieneEstrategia()} 
	method mitadPersonajes() = personajes.size()/ 2
	
	override method puedeRealizarse() = personajes.sum{p=>p.copas()} >= 60
	
	method cantParticipantes() = personajes.size()
		
}


class Personaje {
	
	var property copas = 0
	
	method darCopas(cantidad){
		copas += cantidad
	}
	
}

class Arquero inherits Personaje{
	
	var agilidad
	var rango 

	method destreza() = agilidad * rango 
	method tieneEstrategia() = rango > 100
}


class Ballestero inherits Arquero{
		
	override method destreza() = super() * 2 
	
}


class Guerrera inherits Personaje{
	
	var fuerza
	var tieneEstrategia

	method destreza() = fuerza * 1.5
	method tieneEstrategia() = tieneEstrategia
}

