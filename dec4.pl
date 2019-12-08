:- use_module(helpers).

adj_digits([X|[Y|_]]) :- X = Y.
adj_digits([_|[Y|As]]) :- adj_digits([Y|As]).

adj_digits_rec([], Ys) :- length(Ys, LY), LY = 2.
adj_digits_rec([X|Xs], []) :- adj_digits_rec(Xs, [X]).
adj_digits_rec([X|Xs], [Y|Ys]) :- X = Y, adj_digits_rec(Xs, [X|[Y|Ys]]).
adj_digits_rec([X|_], [Y|Ys]) :- X \= Y, length([Y|Ys], LY), LY = 2.
adj_digits_rec([X|Xs], [Y|_]) :- X \= Y, adj_digits_rec(Xs, [X]).

adj_digits_only_pairs(P) :- adj_digits_rec(P, []).

mono_inc([]).
mono_inc([_]).
mono_inc([X|[Y|As]]) :- X =< Y, mono_inc([Y|As]).

fits(P) :- adj_digits(P), mono_inc(P).
fits2(P) :- adj_digits_only_pairs(P), mono_inc(P).

fits_between(L, F, U, N) :- 
    between(L, U, N), 
    digit_list(N, P),
    call(F, P).

run(L, U, P, N) :- setof(M, fits_between(L, P, U, M), R), length(R, N).

part1(L, U, N) :- run(L, U, fits, N).
part2(L, U, N) :- run(L, U, fits2, N). 

% Input: 156218-652527

% part 1 solution: part1(156218, 652527, N).
% part 2 solution: part2(156218, 652527, N).
