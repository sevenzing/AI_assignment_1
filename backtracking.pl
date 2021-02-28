:- module(backtracking, [
    backtracking/5
    ]).

:-use_module(library(clpfd)).
:-use_module(tools).
:-use_module(pointTools).

backtracking(HomePoint, DoctorPoint, MaskPoint, CovidsPoints, ThePath):-
    backtracking_helper(0-0, HomePoint, [], DoctorPoint, MaskPoint, CovidsPoints, ThePath).

/*
    If actor reaches home
*/
backtracking_helper(ActorPoint, HomePoint, V, _, _, _, P) :-
    % if not equalPoints(ActorPoint, HomePoint): return
    equalPoints(ActorPoint, HomePoint),
    % return V.append(ActorPoint)
    append(V, [ActorPoint], P).

/*
    We did't reach the home, try to make a step
*/
backtracking_helper(ActorPoint, HomePoint, Visited, DoctorPoint, MaskPoint, CovidsPoints, ThePath):-
    % PossibleMove = adjacentPoints(ActorPoint)
    adjacentPoints(ActorPoint, PossibleMove),
    % Visited_ = Visited.append(ActorPoint)
    append(Visited, [ActorPoint], Visited_),
    
    % if not inMaze(PossibleMove): return
    % if member(PossibleMove, Visited_): return
    inMaze(PossibleMove), not(member(PossibleMove, Visited_)),
    
    % return backtracking_helper( ... )
    backtracking_helper(PossibleMove, HomePoint, Visited_, DoctorPoint, MaskPoint, CovidsPoints, ThePath).


