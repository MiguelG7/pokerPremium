# Poker Premium

Poker Premium es una aplicación de la modalidad de poker "Texas hold 'em" que detectará las parejas, tríos, escaleras y colores principales que surjan en la mesa. Funcionará mediente dos inputs: tu mano y las 5 cartas de la mesa.

## Tabla de Contenidos

- [Instalación](#instalación)
- [Uso](#uso)
- [Licencia](#licencia)
- [Contacto](#contacto)

## Instalación

Proporciona pasos claros y concisos para que otros desarrolladores puedan instalar y ejecutar tu proyecto. Si es necesario, incluye ejemplos de comandos o scripts.

```bash
git clone https://github.com/MiguelG7/pokerPremium.git
```

## Uso

```
?- pokerPremium.
BIENVENIDO A POKERPREMIUM, DETECTOR DE PAREJAS, TRIOS, ESCALERAS Y COLOR
Introduce DOS cartas propias (2345678910jqka + hdsc) (Ejemplo: ["10h","9h"]): ['10h','9h'].
Introduce entre 3 y 5 cartas en la mesa (2345678910jqka + hdsc) (Ejemplo: ["10c","4c","5c","6c","10d"]): ['10c','4c',"5c",'6c','10d'].

true.

?- totalCartas(X).
X = '10h' ;
X = '9h' ;
X = '10c' ;
X = '4c' ;
X = '5c' ;
X = '6c' ;
X = '10d'.

?- totalCartas(X).
X = '10h' ;
X = '9h' ;
X = '10c' ;
X = '4c' ;
X = '5c' ;
X = '6c' ;
X = '10d'.

?- manoCartas(X).
X = '10h' ;
X = '9h'.

?- mesaCartas(X).
X = '10c' ;
X = '4c' ;
X = '5c' ;
X = '6c' ;
X = '10d'.

?- combos.
Detectando su mayor combo...Las tríos existentes son: 10h , 10c y  10h
true.

?- borrarCartas.
true.

?- totalCartas(X).
false.
```

## Licencia
Este proyecto está bajo la Licencia MIT - vea el archivo [LICENSE](LICENSE) para más detalles.

## Contacto
