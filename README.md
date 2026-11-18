# Parcial objetos

Curso: Martes Noche 2026

- [Enunciado](Parcial%20Objetos%20-%20Barbie.pdf)
- [Código](example.wlk)

## Solución

### Parte 1
1. Realizar 3 diagramas dinámicos: cómo se vería el estado luego de cada línea de la consola.

**Solución:**

```wollok
var ariel = new Sirena(brillo=80)
```

<img height="30%" alt="image" src="https://github.com/user-attachments/assets/17d91c2f-e8be-497e-9867-ed1019cab290" />

```wollok
var fiestita = new Fiesta()
```
<img height="30%" alt="image" src="https://github.com/user-attachments/assets/868dd580-8511-488a-aeaa-42040178c1ac" />


```wollok
fiestita.agregarInvitado(ariel)
```

<img height="30%" alt="image" src="https://github.com/user-attachments/assets/dd767e6b-11b0-4ef9-b7e5-4c5e504ba76f" />


2. Responder Verdadero o Falso y justificar en todos los casos:

a. En esta solución pueden existir las barbies sin profesión.

**Respuesta**: Verdadero. Así como `new Sirena()` crea una barbie sirena, `new Barbie()` crea una barbie sin profesión.

b. Falta que la Presidenta, Sirena y Astronauta hereden de Barbie.

**Respuesta**: Falso. No hay comportamiento en común para compartir entre las clases de barbie, por lo tanto la herencia no tiene sentido. 

c. En esta solución hay clases abstractas.

**Respuesta**: Falso. Todas las clases están pensadas para instanciarse, por lo tanto no hay clases abstractas, son todas concretas.

d. Con esta solución es posible que una barbie cambie de profesión. (Si lo es, mostrar cómo, si no lo es, justificar)

**Respuesta**: No es posible cambiar de profesión. No puedo hacer `ariel = new Astronauta`, porque cambia la _identidad_ del objeto. En el ejemplo de la consola, ariel ya estaba en la lista de invitados, y este nuevo objeto no. Para ello, la barbie debería tener un objeto separado que sea la profesión, resolverlo por _composición_.

3a. codificar en Wollok una solución que resuelva los problemas encontrados. 

**Respuesta:**
```wollok
class Barbie {
  var profesion = sinProfesion
  method brillo() = profesion.brillo()
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
}
```

3b. Incluir la nueva versión de la consola para agregar a ariel a la fiestita (si es que cambia).

**Respuesta**:
```wollok
var profesionAriel = new Sirena(brillo=80)
var ariel = new Barbie(profesion=profesionAriel)
var fiestita = new Fiesta()
fiestita.agregarInvitado(ariel)
```

3c. Hacer el diagrama dinámico final nuevamente.

**Respuesta**:

<img height="30%" alt="image" src="https://github.com/user-attachments/assets/fdfdb83a-343e-472e-ad2e-19b9de5d94cb" />

### Parte 2

4.a Debería lanzarse una excepción en el método agregarInvitado(inv).

**Respuesta**: Verdadero. Me están pidiendo agregar un invitado a una fiesta que por enunciado "no cualquiera debe poder". Entonces, corresponde lanzar una excepción de dominio, porque _no puedo hacer lo que el mensaje dice que hace_.

4.b El método esEpica() tiene problemas de declaratividad.

**Respuesta**; Verdadero. El método resuelve el problema de saber si "todos tienen más de 50 de brillo" de una forma imperativa, enfocada en el cómo y no en el qué. Muestra el algoritmo por el cual se recorre la lista buscando alguno que no cumpla (cómo). Una respuesta más declarativa podría ser usando el mensaje all (qué).

4.c Se pueden agregar los requisitos para las distintas fiestas sin cambiar el código existente.

**Respuesta**: Verdadero. Al delegar la lógica haciendo `self.admite(inv)` eso puede resolverse en una subclase nueva o delegando en un objeto usando composición.

5. De acuerdo a las respuestas anteriores, codificar una solución en Wollok que resuelva todos los problemas planteados, incluyendo los requisitos de admisión.

**Respuesta**

```wollok
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

// A las barbies se les agrega   method esFashion() = self.brillo() > 0
// A Alan se le agrega  method esFashion() = false

```

6. Responder justificando conceptualmente: en la solución del punto anterior, ¿es posible agregar este nuevo requerimiento sin modificar el código existente?.

**Respuesta**: Verdadero. Se puede tratar **polimórficamente** a los grupos como si fueran un invitado más. Sólo deben respetar la interfaz de un invitado (como alan o las barbies): entender los mensajes `brillo()` y `esFashion()`

7. Codificarlo en Wollok.

**Respuesta**

```wollok
class Grupo {
  const participantes = []
  
  method brillo() = self.sumaBrillos() * 2
  
  method sumaBrillos() = participantes.sum({participante => participante.brillo()}) // vale tmb map con sum, pero así es un poquito más declarativo.
  
  method esFashion() = self.cantFashions() > self.cantNoFashions()

  method cantFashions() = participantes.count({participante => participante.esFashion()}) //vale tmb filter con size, pero así es un poquito más declarativo.
  
  method cantNoFashions() = participantes.size() - self.cantFashions()
}
``` 

8. Hacer un diagrama estático de las partes 2 y 3.

**Respuesta**:

[Acá el PlantUML](estatico.puml)


