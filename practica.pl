/* Copyright 2023 Miguel Gamboa
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. */

:- dynamic manoCartas/1.
:- dynamic mesaCartas/1.
:- dynamic totalCartas/1.
% Palos
palo(corazones, h).
palo(diamantes, d).
palo(picas, s).
palo(tréboles, c).

% Cartas numeradas
carta(2, corazones, '2h').
carta(3, corazones, '3h').
carta(4, corazones, '4h').
carta(5, corazones, '5h').
carta(6, corazones, '6h').
carta(7, corazones, '7h').
carta(8, corazones, '8h').
carta(9, corazones, '9h').
carta(10, corazones, '10h').
carta(2, diamantes, '2d').
carta(3, diamantes, '3d').
carta(4, diamantes, '4d').
carta(5, diamantes, '5d').
carta(6, diamantes, '6d').
carta(7, diamantes, '7d').
carta(8, diamantes, '8d').
carta(9, diamantes, '9d').
carta(10, diamantes, '10d').
carta(2, picas, '2s').
carta(3, picas, '3s').
carta(4, picas, '4s').
carta(5, picas, '5s').
carta(6, picas, '6s').
carta(7, picas, '7s').
carta(8, picas, '8s').
carta(9, picas, '9s').
carta(10, picas, '10s').
carta(2, tréboles, '2c').
carta(3, tréboles, '3c').
carta(4, tréboles, '4c').
carta(5, tréboles, '5c').
carta(6, tréboles, '6c').
carta(7, tréboles, '7c').
carta(8, tréboles, '8c').
carta(9, tréboles, '9c').
carta(10, tréboles, '10c').

% Cartas de figuras
carta(jota, corazones, jh).
carta(reina, corazones, qh).
carta(rey, corazones, kh).
carta(as, corazones, ah).
carta(jota, diamantes, jd).
carta(reina, diamantes, qd).
carta(rey, diamantes, kd).
carta(as, diamantes, ad).
carta(jota, picas, js).
carta(reina, picas, qs).
carta(rey, picas, ks).
carta(as, picas, as).
carta(jota, tréboles, jc).
carta(reina, tréboles, qc).
carta(rey, tréboles, kc).
carta(as, tréboles, ac).

% Definición de las cartas y palos (código previo)

pokerPremium:-
    write('BIENVENIDO A POKERPREMIUM, DETECTOR DE PAREJAS, TRIOS, ESCALERAS Y COLOR\nIntroduce DOS cartas propias (2345678910jqka + hdsc) (Ejemplo: ["10h","9h"]: '),
    read(CartasPropias),
    altaPropias(CartasPropias),

    write('Introduce entre 3 y 5 cartas en la mesa (2345678910jqka + hdsc) (Ejemplo: ["2d", "4s", "6h", "8c", "ah"]: '),
    read(CartasMesa),
    altaMesa(CartasMesa).

altaPropias([]).
altaPropias([Carta | Resto]) :-
    assert(manoCartas(Carta)),
    assert(totalCartas(Carta)),
    altaPropias(Resto).

altaMesa([]).
altaMesa([Carta | Resto]) :-
    assert(mesaCartas(Carta)),
    assert(totalCartas(Carta)),
    altaMesa(Resto).

% Regla para verificar si hay dos cartas con el mismo número pero diferente palo en totalCartas
parejaCartas :-
    totalCartas(Carta1),
    totalCartas(Carta2),
    carta(N, Palo1, Carta1),
    carta(N, Palo2, Carta2),
    Carta1 \= Carta2,
    Palo1 \= Palo2,
    format('Las parejas existentes son: ~w y ~w\n', [Carta1, Carta2]).

trioCartas :-
    totalCartas(Carta1),
    totalCartas(Carta2),
    totalCartas(Carta3),
    carta(N, Palo1, Carta1),
    carta(N, Palo2, Carta2),
    carta(N, Palo3, Carta3),
    Carta1 \= Carta2, Carta2 \= Carta3, Carta3 \= Carta1,
    Palo1 \= Palo2, Palo2\= Palo3,
    format('Las tríos existentes son: ~w , ~w y  ~w\n', [Carta1, Carta2, Carta3]).

escaleraCartas :-
    findall(N, (carta(N, _, Carta), totalCartas(Carta)), Numeros),
    sort(Numeros, NumerosOrdenados),
    length(NumerosOrdenados, Longitud),
    Longitud >= 5,
    esEscalera(NumerosOrdenados),
    write('Escalera encontrada: '),
    imprimirEscalera(NumerosOrdenados).

esEscalera([A, B, C, D, E | _]) :- E is A + 4.
esEscalera([_ | Resto]) :- esEscalera(Resto).

imprimirEscalera([]) :- nl.
imprimirEscalera([N | Resto]) :-
    write(N),
    write(' '),
    imprimirEscalera(Resto).

colorCartas :-
    findall(Palo, (carta(_, Palo, Carta), totalCartas(Carta)), Palos),
    todosMismos(Palos),
    write('Color encontrado: '),
    imprimirPalos(Palos).

todosMismos([_]).
todosMismos([Palo1, Palo2 | Resto]) :- Palo1 = Palo2, todosMismos([Palo2 | Resto]).

imprimirPalos([]) :- nl.
imprimirPalos([Palo | Resto]) :-
    write(Palo),
    write(' '),
    imprimirPalos(Resto).

combos:-
    write('Detectando su mayor combo...'),

    (colorCartas, !);
    (escaleraCartas,!);
    (trioCartas,!);
    parejaCartas,!.

borrarCartas:-
    retractall(manoCartas(_)),
    retractall(mesaCartas(_)),
    retractall(totalCartas(_)).
