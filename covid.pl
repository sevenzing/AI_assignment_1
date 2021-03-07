:- module(covid, [
    validCell/2,
    inCovidZone/1
    ]).

:-use_module(library(clpfd)).
:-use_module(pointTools).

% import map
:-use_module(map).

inCovidZone(Cell) :-
    covid(CovidCell),
    adjacentOrEqualPoints(CovidCell, Cell).

/*
    Check if cell is covid free
*/
covidFree(Cell, CompletedPath):-
    % if cell in covid zone
    ((inCovidZone(Cell)),
      % if there is no doctor and mask in path, then return false
        (
            doctor(Dpoint), member(Dpoint, CompletedPath); 
            mask(MPoint), member(MPoint, CompletedPath)
        )
    );
    % otherwise we should not be in covid zone!
    not(inCovidZone(Cell)).

/*
    Check if cell in maze, not in CompletedPath and cell is covid-free
*/
validCell(Cell, CompletedPath) :-
    inMaze(Cell),
    % if Next move is not in Completed path
    not(member(Cell, CompletedPath)),
    % if Next move is covid save move
    covidFree(Cell, CompletedPath).
