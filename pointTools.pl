:- module(pointTools, [
    equalPoints/2, 
    adjacentPoints/2,
    adjacentOrEqualPoints/2,
    cellDistance/3,
    mooreDistance/3
    ]).
:-use_module(library(clpfd)).

/*
    Are two points equal?
*/
equalPoints(X-Y, X_-Y_) :-
    X #= X_,
    Y #= Y_.

adjacentOrEqualPoints(X1-Y1, X2-Y2) :-
    (X1 - X2 #= 1;X1 - X2 #= -1;X1 - X2 #= 0),
    (Y1 - Y2 #= 1;Y1 - Y2 #= -1;Y1 - Y2 #= 0).

/*
    Are two points adjacent?
*/
adjacentPoints(P1, P2) :-
    adjacentOrEqualPoints(P1, P2),
    not(equalPoints(P1, P2)).

cellDistance(X1-Y1, X2-Y2, D) :-
    D is abs(X1 - X2) + abs(Y1 - Y2).

mooreDistance(X1-Y1, X2-Y2, D) :-
    D is max(abs(X1 - X2), abs(Y1 - Y2)).







    
    
    
