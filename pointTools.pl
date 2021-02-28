:- module(pointTools, [
    equalPoints/2, 
    adjacentPoints/2
    ]).
:-use_module(library(clpfd)).

/*
    Are two points equal?
*/
equalPoints(X-Y, X_-Y_) :-
    X #= X_,
    Y #= Y_.

/*
    Are two points adjacent?
*/
adjacentPoints(X1-Y1, X2-Y2) :-
    (X1 - X2 #= 1;X1 - X2 #= -1;X1 - X2 #= 0),
    (Y1 - Y2 #= 1;Y1 - Y2 #= -1;Y1 - Y2 #= 0),
    not(equalPoints(X1-Y1, X2-Y2)).