:- module(helpers, [file_to_string/2]).
:- use_module(library(readutil)).

file_to_string(I, O) :-
    read_file_to_string(I, T, []),
    split_string(T, "\n", "", O).