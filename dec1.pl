:- use_module(helpers).

fuel(I, O) :- X = div(I, 3), O is max(X - 2, 0).

rec_fuel(A, I, O) :- O is A, I =< 0.
rec_fuel(A, I, O) :- fuel(I, T), B = A + T, rec_fuel(B, T, O), I > 0.

run(In, P, T) :- 
    file_to_string(In, R),
    maplist(atom_number, R, S),
    call(P, S, T).

part1(In, R) :-
    maplist(fuel, In, S),
    sum_list(S, R).
    
part2(In, R) :- 
    maplist(rec_fuel(0), In, T),
    sum_list(T, R).

    


