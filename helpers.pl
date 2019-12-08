:- module(helpers, [file_to_stringlist/3, file_to_numberlist/3, char_to_string/2, digit_list/2]).
:- use_module(library(readutil)).

file_to_stringlist(I, Sep, O) :-
    read_file_to_string(I, T, []),
    split_string(T, Sep, "", O).

file_to_numberlist(I, Sep, O) :-
    file_to_stringlist(I, Sep, T),
    maplist(atom_number, T, O).

char_to_string(C, S) :- string_chars(S, [C]).

digit_list(I, L) :-
    number_string(I, S),
    string_chars(S, Cs),
    maplist(char_to_string, Cs, L).