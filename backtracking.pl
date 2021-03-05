:- module(backtracking, [
    backtracking/5
    ]).

:-use_module(library(clpfd)).

:-use_module(pointTools).
:-use_module(covid).


/*
    Return adjacent Point to `From`,
    If there are many of them, return in ascending order of distance to the house
*/
findNext(From, Next) :- 
    % find all adjacent points to From
    findall(P, adjacentPoints(From, P), PossibleMoves),
    % assign distance to home for every point.
    % Pairs = [Cost1-Point1, Cost2-Point2, ... ]
    map_list_to_pairs(distanceToHome, PossibleMoves, Pairs),
    % Just sort by distances
    keysort(Pairs, SortedPairs),
    % get values (remove keys from list)
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

    % for Next in adjacentPoints(From):
    findNext(From, Next),
        % check if next cell is ok
        validCell(Next, CompletedPath),
        
        % NewCompletedPath = CompletedPath + [Next]
        append(CompletedPath, [Next], NewCompletedPath),
        % PathFromRecursion = backtracking(...)
        backtracking(Next, To, NewCompletedPath, MaxLength, PathFromRecursion),
        % return [Next] + PathFromRecursion
        ThePath = [Next|PathFromRecursion].


