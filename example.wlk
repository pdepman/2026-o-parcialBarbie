class Presidenta {
  var aniosPresidenta = 0
  
  method brillo() = 100 + (5 * aniosPresidenta)
}

class Sirena {
  var brillo = 60
  
  method brillo() = brillo
}

class Astronauta {
  var cantMisiones = 0
  
  method brillo() = 10 * cantMisiones
}

object alan {
  method brillo() = 1
  
  method esFashion() = false
}

class Barbie {
  var property profesion
  
  method brillo() = profesion.brillo()
  
  method esFashion() = self.brillo() > 0
}

class Fiesta {
  const invitados = []
  
  method agregarInvitado(inv) {
    if (self.admite(inv)) invitados.add(inv)
  }
  
  method esEpica() {
    var epica = true
    invitados.forEach({ inv => if (inv.brillo() < 50) {epica = false} })
    return epica
  }
  
  method admite(invitado)
  
  method pan() = self.esEpica()
}

class Exclusiva inherits Fiesta {
  var brilloRequerido
  
  override method admite(invitado) = invitado.brillo() > brilloRequerido
}

class ConCupo inherits Fiesta {
  var cupo
  
  override method admite(invitado) = invitados.size() < cupo
}

class Vip inherits Fiesta {
  override method admite(invitado) = invitado.esFashion()
}

class Grupo {
  const participantes = []
  
  method brilloGrupo() = participantes.sum(
    { participante => participante.brillo() }
  )
  
  method brillo() = self.brilloGrupo() * 2
  
  method esFashion() = participantes.count(
    { participante => participante.esFashion() }
  ) > participantes.count({ participante => !participante.esFashion() })
}