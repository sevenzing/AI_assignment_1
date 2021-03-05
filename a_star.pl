:- module(a_start, [
    
    ]).

:-use_module(library(clpfd)).
:-use_module(pointTools).
:-use_module(covid).

% import map
:-use_module(map).

/*
Cell   = X-Y
Point  = Cell-CovidSafeFlag
Vertex = Point-Cost = X-Y-CovidSafeFlag-Cost
*/

a_star() :-
    true.