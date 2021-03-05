:- module(backtracking, [
    backtracking/5
    ]).

:-use_module(library(clpfd)).

:-use_module(pointTools).
:-use_module(covid).

% import map
:-use_module(map).


distanceToHome(Point, D) :-
    home(X-Y),
    cellDistance(Point, X-Y, D).


findNext(From, Next) :- 
    % find all adjacent points to From
    findall(P, adjacentPoints(From, P), PossibleMoves),
    % assign distance to home for every point.
    % Pairs = [Cost1-Point1, Cost2-Point2, ... ]
    map_list_to_pairs(distanceToHome, PossibleMoves, Pairs),
    % Just sort by distances
    keysort(Pairs, SortedPairs),
    % get values (remove distances from list)
    pairs_values(SortedPairs, ResultPoints),
    % yeild elements from ResultPoints
    member(Next, ResultPoints).
    
backtracking(X, X, _, _, []).
backtracking(From, To, CompletedPath, MaxLength, ThePath) :-
    % if length of path greater than possible, than return false
    length(CompletedPath, Length),
    
    Length #=< MaxLength,
    mooreDistance(From, To, MinimalDistanceToHome),
    MinimalDistanceToHome - Length + 1 #=< MaxLength,

    % Next = adjacentPoints(From)
    findNext(From, Next),
    
    % check if next cell is ok
    validCell(Next, CompletedPath),
    
    append(CompletedPath, [Next], NewCompletedPath),

    backtracking(Next, To, NewCompletedPath, MaxLength, PathFromRecursion),
    
    ThePath = [Next|PathFromRecursion].


