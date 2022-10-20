class Mision {
	
	
	var destreza
	method superada() = self.destrezaSuficiente() && self.personajeTieneEstrategia()
	
	method destrezaSuficiente()
	
	method personajeTieneEstrategia() 
}

class MisionIndividual inherits Mision {
	
	var personaje
	var dificultad
	
	override method destrezaSuficiente() = personaje.destreza() > dificultad

	override method personajeTieneEstrategia() = personaje.tieneEstrategia()
	
}

class MisionEquipo inherits Mision {
	
	var personajes = []
	
	override method destrezaSuficiente() = personajes.all{p=>p.destreza()>400} 
		
}