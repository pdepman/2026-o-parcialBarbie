class Barbie {
  var profesion = sinProfesion
  method brillo() = profesion.brillo()
  method esFashion() = self.brillo() > 0
  method profesion(prof) {
    profesion = prof
  }
}

// Esto ahora no son Barbies, son Profesiones:
object sinProfesion {
  method brillo() = 0
}
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


class Fiesta {
  const invitados = []
  
  method agregarInvitado(inv) {
    if (!self.admite(inv)) throw new DomainException(message = "No se admite este invitado")
    invitados.add(inv)
  }
  
  method esEpica() = invitados.all({inv => inv.brillo() > 50})
  
  method admite(invitado)
}

class Exclusiva inherits Fiesta {
  var brilloRequerido = 10
  override method admite(invitado) = invitado.brillo() > brilloRequerido
}

class ConCupo inherits Fiesta {
  var cupo = 5
  override method admite(invitado) = invitados.size() < cupo
}

class Vip inherits Fiesta {
  override method admite(invitado) = invitado.esFashion()
}

class Grupo {
  const participantes = []
  
  method sumaBrillos() = participantes.sum({participante => participante.brillo()})
  
  method brillo() = self.sumaBrillos() * 2
  
  method esFashion() = self.cantFashions() > self.cantNoFashions()

  method cantFashions() = participantes.count({participante => participante.esFashion()})
  
  method cantNoFashions() = participantes.size() - self.cantFashions()
}