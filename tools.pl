:- module(tools, [
    inMaze/1
    ]).

:-use_module(config).
:-use_module(library(clpfd)).


/*
    Check if point(X, Y) in maze
*/
inMaze(X-Y) :-
    mazeSize(MSize),
    [X, Y] ins 0..MSize.
