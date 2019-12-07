:- use_module(helpers).

replace([], _, _, _, B) :- B = [].
replace([_|As], Pre, I, E, B) :- append(Pre, [E|As], B), I = 0.
replace([A|As], Pre, I, E, B) :- append(Pre, [A], Q), J is I - 1, replace(As, Q, J, E, B).

add(X, Y, Z) :- Z is X + Y.
mul(X, Y, Z) :- Z is X * Y.

op(A, C, Opc, P, R, Rpos) :-
    nth0(C, A, Op), Op = Opc,
    I is C + 1, J is C + 2, Ri is C + 3, 
    nth0(I, A, Xpos), nth0(J, A, Ypos), nth0(Ri, A, Rpos),
    nth0(Xpos, A, X), nth0(Ypos, A, Y),
    call(P, X, Y, R).

apply_op(A, C, Opc, O, B) :-
    length(A, L), C < L,
    op(A, C, Opc, O, R, Rpos),    
    replace(A, [], Rpos, R, D),
    CC is C + 4,
    prog(D, CC, B).

prog(A, C, B) :- apply_op(A, C, 1, add, B).
prog(A, C, B) :- apply_op(A, C, 2, mul, B).
prog(A, _, B) :- B = A.

calibrate(A, B, N, V) :-
    replace(A, [], 1, N, C),
    replace(C, [], 2, V, B).

part1(In, R) :-
    file_to_numberlist(In, ",", T),
    calibrate(T, U, 12, 2),
    prog(U, 0, V),
    nth0(0, V, R).

part2(In, N, V, O) :-
    file_to_numberlist(In, ",", T), !,
    between(0, 99, N),
    between(0, 99, V),
    calibrate(T, U, N, V),
    prog(U, 0, X),
    nth0(0, X, R),
    R = 19690720,
    O is (100 * N) + V.

% part 1 solution: part1('path-to-input', R).
% part 2 solution: part2('path-to-input', N, V, O).