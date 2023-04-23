start :-
repeat,
main_menu,
readln(A),
check(A),
!.

fam :-
repeat,
fam_menu,
readln(A),
fam_check(A),
!.

func :-
repeat,
dop_func_menu,
readln(B),
func_check(B),
!.

dop_func_menu :-
writeln("\nВеберите с каким числом производить вычисления:"),
writef("1 - Работа с положительным числом\n2 - Работа с отрицательным числом\n3 - Завершение работы\n").

main_menu :-
writeln("\nВыберите комманду из списка:"),
writef("1 - Работа с семейным древом\n2 - Вычисление функции sh x\n3 - Завершение работы программы\n").

fam_menu :-
writeln("\nВыберите комманду из списка:"),
writef("1 - Альфия мать Софьи?\n2 - Надежда не дочь Альфии?\n3 - Петр является отцом Максима и дедушкой Константина?\n4 - Дмитрий является отцом или дядей?\n5 - Кто является внуком Юлии?\n6 - Надежда старше 20 лет\n7 - Выход\n").

func_menu :-
writeln("\nВыберите комманду из списка:"),
writef("1 - Прямое вычисление функции\n2 - Вычисление функции по приближенной формуле \n3 - Сравнение реального значения и приближенного\n4 - Выход\n").

func_check([Command]) :-
Command = 1 ->( func_menu,
readln(A),
func_check_pos(A), fail
);
Command = 2 ->( func_menu,
readln(A),
func_check_neg(A), fail
);
Command = 3 -> writeln("Выход"), !.

check([Command]) :-
Command = 1 -> (fam, fail);
Command = 2 -> (func, fail);
Command = 3 -> writeln("Программа завершена").

fam_check([Command]) :-
Command = 1 -> (goal1, fail);
Command = 2 -> (goal2, fail);
Command = 3 -> (goal3, fail);
Command = 4 -> (goal4, fail);
Command = 5 -> (goal5, fail);
Command = 6 -> (goal6, fail);
Command = 7 -> writeln("Выход"), !.

func_check_pos([Command]) :-
Command = 1 -> (
writeln("Введите X:"), readln(ListX), ListX = [X],
start_func(X, Res),
format("X = ~w. Функция = ~w", [X, Res]),
fail
);
Command = 2 -> (
writeln("Введите X:"), readln(ListX), ListX = [X],
writeln("Введите N:"), readln(ListN), ListN = [N],
formula(X, N, Res),
format("X = ~w and N = ~w. Функция = ~w", [X, N, Res]),
fail
);
Command = 3 -> (
writeln("Введите X:"), readln(ListX), ListX = [X],
writeln("Введите N:"), readln(ListN), ListN = [N],
test(X, N, ResFunc, ResFormula),
format("\nWith X = ~w and N = ~w.", [X, N]),
format("\nFunction Result = ~w", [ResFunc]),
format("\nFormula Result = ~w", [ResFormula]),
format("\n"),
fail
);
Command = 4 -> writeln("Выход"), !.


func_check_neg([Command]) :-
Command = 1 -> (
writeln("Введите модуль X:"), readln(ListX), ListX = [X],
start_func((-X), Res),
format("X = ~w. Функция = ~w", [(-X), Res]),
fail
);
Command = 2 -> (
writeln("Введите модуль X:"), readln(ListX), ListX = [X],
writeln("Введите N:"), readln(ListN), ListN = [N],
formula((-X), N, Res),
format("X = ~w and N = ~w. Функция = ~w", [(-X), N, Res]),
fail
);
Command = 3 -> (
writeln("Введите модуль X:"), readln(ListX), ListX = [X],
writeln("Введите N:"), readln(ListN), ListN = [N],
test((-X), N, ResFunc, ResFormula),
format("\nWith X = ~w and N = ~w.", [(-X), N]),
format("\nFunction Result = ~w", [ResFunc]),
format("\nFormula Result = ~w", [ResFormula]),
format("\n"),
fail
);
Command = 4 -> writeln("Выйти из режима работы с функцией"), !.




% Лаба_1
% Задание простого двуместного предиката - родитель.
parent(dmitriy, sofia).
parent(dmitriy, konstantin).
parent(alfia, sofia).
parent(alfia, konstantin).
parent(yulia, dmitriy).
parent(petr, dmitriy).
parent(yulia, maksim).
parent(petr, maksim).
parent(maksim, nadejda).
parent(ekaterina, nadejda).

% Задание простого одноместного предиката - мужчина.
male(dmitriy).
male(konstantin).
male(maksim).
male(petr).

% Задание простого одноместного предиката - женщина.
female(sofia).
female(alfia).
female(nadejda).
female(yulia).
female(ekaterina).

% Задание простого двуместного предиката - возраст.
age(sofia, 19).
age(konstantin, 14).
age(alfia, 44).
age(dmitriy, 46).
age(nadejda, 24).
age(maksim, 50).
age(ekaterina, 49).
age(yulia, 72).
age(petr, 76).

% Задание сложного предиката - мать.
mother(X, Y) :-
female(X),
parent(X, Y).
% format("~w mother for ~w", [X, Y]).

% Задание сложного предиката - отец.
father(X, Y) :-
male(X),
parent(X, Y).
% format("~w father for ~w", [X, Y]).

% Задание сложного предиката - бабушка.
grandmother(X, Z) :-
female(X),
parent(X, Y),
parent(Y, Z).
% format("~w grandmother for ~w", [X, Z]).

% Задание сложного предиката - дедушка.
grandfather(X, Z) :-
male(X),
parent(X, Y),
parent(Y, Z).
% format("~w grandfather for ~w", [X, Z]).

% Задание сложного предиката - дядя.
uncle(X, Y) :-
male(X),
parent(G, X),
parent(G, Z),
parent(Z, Y),
not(parent(X, Y)).
% format("~w uncle for ~w", [X, Y]).

% Задание сложного предиката - тетя.
aunt(X, Y) :-
female(X),
parent(G, X),
parent(G, Z),
parent(Z, Y).
% format("~w aunt for ~w", [X, Y]).

% Цель 1 - "Альфия мать Софьи"
goal1 :-
writeln("Alfia is Sofia's mother :"),
mother(alfia, sofia) ->
writeln("Yes").

% Цель 2 - "Надежда не дочь Альфии"
goal2 :-
writeln("Alfia is not Nadejda's mother :"),
not(mother(alfia, nadejda))->
writeln("Yes").

% Цель 3 - "Петр является отцом Максима и дедушкой Константина"
goal3 :-
writeln("Petr is Maksim's father and Konstantin's grandfather :"),
parent(petr, maksim),
grandfather(petr, konstantin) ->
writeln("Yes").

% Цель 4 - "Дмитрий является отцом, либо является дядей"
goal4 :-
writeln("Dmitiy is father or uncle :"),
( parent(dmitriy, _);
uncle(dmitriy, _) )->
writeln("Yes").

% Цель 5 - Кто является внуком Юлии?
goal5 :-
writeln("Who is Yulia's grandchild:"),
grandmother(yulia, X),
format("Yulia is grandmother for ~w\n", [X]).

% Цель 6 - Надежда старше 20 лет?
goal6 :-
writeln("Nadejda is older than 20 :"),
(age(nadejda, X),
X > 20 ) ->
writeln("Yes").
%
%
%
%
%
%
%
%
% Лаба_2
% Вариант 12
% Функция: sh x
% Ограниение: |x| < inf
% Приближенная формула: x + x^3/3! + x^5/5!...+... x^(2n+1)/(2n+1)! + ...

% Расчет формулы точным способом
start_func(X, Res) :-
Y is abs(X),
not(number(X)) -> format("Error: ~w is not number", [X]), fail;
%Y > inf -> format("Error: ~w is more than inf", [X]), fail;
Res is sinh(X).

% Расчет n-го коэффициента
coef(N, Res) :-
N = 1 -> Res is 1/6;
N > 1 -> (
K is (N - 1),
coef(K, ResLast),
Res is ResLast / ((2*N + 1) * (2 * N))
).

% Расчет приближеной формулы с точностью до N
formula(X, N, Res) :-
Y is abs(X),
not(number(X)) -> format("Error: ~w is not number", [X]), fail;
%Y > inf -> format("Error: ~w is more than inf", [X]), fail;
not(integer(N)) -> format("Error: ~w is not integer", [N]), fail;
N =< 0 -> format("Error: ~w is not correct", [N]), fail;
(
N = 1 -> Res is X;
N > 1 -> (
M is (N-1),
coef(M, Dop),
Dop_1 is Dop * X^(2*M +1),
formula(X, M, Dop_res),
Res is Dop_1 + Dop_res
)
).

% Тест
test(X, N, ResFunc, ResFormula) :-
start_func(X, ResFunc),
formula(X, N, ResFormula),
format("Real function result: ~20f~n", [ResFunc]),
format("Formula result: ~20f~n", [ResFormula]),
format("Difference: ~20f~n", [abs(ResFormula - ResFunc)]).
