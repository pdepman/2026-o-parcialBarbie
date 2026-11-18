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

<img width="459" height="131" alt="image" src="https://github.com/user-attachments/assets/17d91c2f-e8be-497e-9867-ed1019cab290" />

```wollok
var fiestita = new Fiesta()
```
<img width="470" height="269" alt="image" src="https://github.com/user-attachments/assets/140e6561-6757-4688-be56-2ffea0557c3e" />


```wollok
fiestita.agregarInvitado(ariel)
```

<img width="455" height="285" alt="image" src="https://github.com/user-attachments/assets/0fa25829-7a80-4843-8c73-9ae82fb77ecc" />

2. Responder Verdadero o Falso y justificar en todos los casos:

a. En esta solución pueden existir las barbies sin profesión.

**Respuesta**: Verdadero. Así como `new Sirena()` crea una barbie sirena, `new Barbie()` crea una barbie sin profesión.

b. Falta que la Presidenta, Sirena y Astronauta hereden de Barbie.

**Respuesta**: Falso. No hay comportamiento en común para compartir entre las clases de barbie, por lo tanto la herencia no tiene sentido. 

c. En esta solución hay clases abstractas.

**Respuesta**: Falso. Todas las clases están pensadas para instanciarse, por lo tanto no hay clases abstractas, son todas concretas.

d. Con esta solución es posible que una barbie cambie de profesión. (Si lo es, mostrar cómo, si no lo es, justificar)

