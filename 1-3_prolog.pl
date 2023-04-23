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
writeln("\n�������� � ����� ������ ����������� ����������:"),
writef("1 - ������ � ������������� ������\n2 - ������ � ������������� ������\n3 - ���������� ������\n").

main_menu :-
writeln("\n�������� �������� �� ������:"),
writef("1 - ������ � �������� ������\n2 - ���������� ������� sh x\n3 - ���������� ������ ���������\n").

fam_menu :-
writeln("\n�������� �������� �� ������:"),
writef("1 - ������ ���� �����?\n2 - ������� �� ���� ������?\n3 - ���� �������� ����� ������� � �������� �����������?\n4 - ������� �������� ����� ��� �����?\n5 - ��� �������� ������ ����?\n6 - ������� ������ 20 ���\n7 - �����\n").

func_menu :-
writeln("\n�������� �������� �� ������:"),
writef("1 - ������ ���������� �������\n2 - ���������� ������� �� ������������ ������� \n3 - ��������� ��������� �������� � �������������\n4 - �����\n").

func_check([Command]) :-
Command = 1 ->( func_menu,
readln(A),
func_check_pos(A), fail
);
Command = 2 ->( func_menu,
readln(A),
func_check_neg(A), fail
);
Command = 3 -> writeln("�����"), !.

check([Command]) :-
Command = 1 -> (fam, fail);
Command = 2 -> (func, fail);
Command = 3 -> writeln("��������� ���������").

fam_check([Command]) :-
Command = 1 -> (goal1, fail);
Command = 2 -> (goal2, fail);
Command = 3 -> (goal3, fail);
Command = 4 -> (goal4, fail);
Command = 5 -> (goal5, fail);
Command = 6 -> (goal6, fail);
Command = 7 -> writeln("�����"), !.

func_check_pos([Command]) :-
Command = 1 -> (
writeln("������� X:"), readln(ListX), ListX = [X],
start_func(X, Res),
format("X = ~w. ������� = ~w", [X, Res]),
fail
);
Command = 2 -> (
writeln("������� X:"), readln(ListX), ListX = [X],
writeln("������� N:"), readln(ListN), ListN = [N],
formula(X, N, Res),
format("X = ~w and N = ~w. ������� = ~w", [X, N, Res]),
fail
);
Command = 3 -> (
writeln("������� X:"), readln(ListX), ListX = [X],
writeln("������� N:"), readln(ListN), ListN = [N],
test(X, N, ResFunc, ResFormula),
format("\nWith X = ~w and N = ~w.", [X, N]),
format("\nFunction Result = ~w", [ResFunc]),
format("\nFormula Result = ~w", [ResFormula]),
format("\n"),
fail
);
Command = 4 -> writeln("�����"), !.


func_check_neg([Command]) :-
Command = 1 -> (
writeln("������� ������ X:"), readln(ListX), ListX = [X],
start_func((-X), Res),
format("X = ~w. ������� = ~w", [(-X), Res]),
fail
);
Command = 2 -> (
writeln("������� ������ X:"), readln(ListX), ListX = [X],
writeln("������� N:"), readln(ListN), ListN = [N],
formula((-X), N, Res),
format("X = ~w and N = ~w. ������� = ~w", [(-X), N, Res]),
fail
);
Command = 3 -> (
writeln("������� ������ X:"), readln(ListX), ListX = [X],
writeln("������� N:"), readln(ListN), ListN = [N],
test((-X), N, ResFunc, ResFormula),
format("\nWith X = ~w and N = ~w.", [(-X), N]),
format("\nFunction Result = ~w", [ResFunc]),
format("\nFormula Result = ~w", [ResFormula]),
format("\n"),
fail
);
Command = 4 -> writeln("����� �� ������ ������ � ��������"), !.




% ����_1
% ������� �������� ����������� ��������� - ��������.
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

% ������� �������� ������������ ��������� - �������.
male(dmitriy).
male(konstantin).
male(maksim).
male(petr).

% ������� �������� ������������ ��������� - �������.
female(sofia).
female(alfia).
female(nadejda).
female(yulia).
female(ekaterina).

% ������� �������� ����������� ��������� - �������.
age(sofia, 19).
age(konstantin, 14).
age(alfia, 44).
age(dmitriy, 46).
age(nadejda, 24).
age(maksim, 50).
age(ekaterina, 49).
age(yulia, 72).
age(petr, 76).

% ������� �������� ��������� - ����.
mother(X, Y) :-
female(X),
parent(X, Y).
% format("~w mother for ~w", [X, Y]).

% ������� �������� ��������� - ����.
father(X, Y) :-
male(X),
parent(X, Y).
% format("~w father for ~w", [X, Y]).

% ������� �������� ��������� - �������.
grandmother(X, Z) :-
female(X),
parent(X, Y),
parent(Y, Z).
% format("~w grandmother for ~w", [X, Z]).

% ������� �������� ��������� - �������.
grandfather(X, Z) :-
male(X),
parent(X, Y),
parent(Y, Z).
% format("~w grandfather for ~w", [X, Z]).

% ������� �������� ��������� - ����.
uncle(X, Y) :-
male(X),
parent(G, X),
parent(G, Z),
parent(Z, Y),
not(parent(X, Y)).
% format("~w uncle for ~w", [X, Y]).

% ������� �������� ��������� - ����.
aunt(X, Y) :-
female(X),
parent(G, X),
parent(G, Z),
parent(Z, Y).
% format("~w aunt for ~w", [X, Y]).

% ���� 1 - "������ ���� �����"
goal1 :-
writeln("Alfia is Sofia's mother :"),
mother(alfia, sofia) ->
writeln("Yes").

% ���� 2 - "������� �� ���� ������"
goal2 :-
writeln("Alfia is not Nadejda's mother :"),
not(mother(alfia, nadejda))->
writeln("Yes").

% ���� 3 - "���� �������� ����� ������� � �������� �����������"
goal3 :-
writeln("Petr is Maksim's father and Konstantin's grandfather :"),
parent(petr, maksim),
grandfather(petr, konstantin) ->
writeln("Yes").

% ���� 4 - "������� �������� �����, ���� �������� �����"
goal4 :-
writeln("Dmitiy is father or uncle :"),
( parent(dmitriy, _);
uncle(dmitriy, _) )->
writeln("Yes").

% ���� 5 - ��� �������� ������ ����?
goal5 :-
writeln("Who is Yulia's grandchild:"),
grandmother(yulia, X),
format("Yulia is grandmother for ~w\n", [X]).

% ���� 6 - ������� ������ 20 ���?
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
% ����_2
% ������� 12
% �������: sh x
% ����������: |x| < inf
% ������������ �������: x + x^3/3! + x^5/5!...+... x^(2n+1)/(2n+1)! + ...

% ������ ������� ������ ��������
start_func(X, Res) :-
Y is abs(X),
not(number(X)) -> format("Error: ~w is not number", [X]), fail;
%Y > inf -> format("Error: ~w is more than inf", [X]), fail;
Res is sinh(X).

% ������ n-�� ������������
coef(N, Res) :-
N = 1 -> Res is 1/6;
N > 1 -> (
K is (N - 1),
coef(K, ResLast),
Res is ResLast / ((2*N + 1) * (2 * N))
).

% ������ ����������� ������� � ��������� �� N
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

% ����
test(X, N, ResFunc, ResFormula) :-
start_func(X, ResFunc),
formula(X, N, ResFormula),
format("Real function result: ~20f~n", [ResFunc]),
format("Formula result: ~20f~n", [ResFormula]),
format("Difference: ~20f~n", [abs(ResFormula - ResFunc)]).
