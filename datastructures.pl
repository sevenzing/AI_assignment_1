:- module(datastructures, [
    initializeCosts/1,
    initializeParentList/1
    ]).


:-use_module(library(clpfd)).
:-use_module(constansts).

% import map
:-use_module(map).


/*
Cell   = X-Y
Point  = Cell-CovidSafeFlag = X-Y-{0,1}

Costs = mapping (Point -> int[Cost])
ToVisit = [ Point ]
VisitedList = [ Point ]
ParentList = mapping (Cell -> Cell)

*/


initializeAssoc(FunctionToFill, Assoc) :-
    initializeAssoc(0, FunctionToFill, Assoc).

initializeAssoc(Iter, _, Assoc) :-
    mazeSize(MSize),
    Iter #= MSize * MSize,
    empty_assoc(Assoc), !.

initializeAssoc(Iter, FunctionToFill, Assoc) :-
    mazeSize(MSize),
    X #= Iter mod MSize,
    Y #= Iter // MSize,
    NextIter #= Iter + 1,
    
    initializeAssoc(NextIter, FunctionToFill, NewCosts),
    
    call(FunctionToFill, X-Y, NewCosts, Assoc).

initialAssignCosts(X-Y, OldCosts, ResultCosts) :-
    infty(INFTY),
    % ResultCosts[X-Y-0] = INFTY
    put_assoc(X-Y-0, OldCosts, INFTY, OldCosts1),
    % ResultCosts[X-Y-0] = INFTY
    % return ResultCosts
    put_assoc(X-Y-1, OldCosts1, INFTY, ResultCosts).

initialAssignParentList(X-Y, OldParentList, ResultParentList) :-
    infty(INFTY),
    % ResultParentList[X-Y-0] = INFTY-INFTY-0
    put_assoc(X-Y-0, OldParentList, INFTY-INFTY-0, OldParentList1),
    % ResultParentList[X-Y-1] = INFTY-INFTY-0
    % return ResultParentList
    put_assoc(X-Y-1, OldParentList1, INFTY-INFTY-0, ResultParentList).

/*
Initialize vertex list
*/
initializeCosts(Costs) :-
    initializeAssoc(initialAssignCosts, Costs).

/*
    Initialize parent list
*/
initializeParentList(ParentList) :-
    initializeAssoc(initialAssignParentList, ParentList).

