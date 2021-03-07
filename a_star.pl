/*
    Refer to https://en.wikipedia.org/wiki/A*_search_algorithm
*/


:- module(a_start, [
        find_astar_path/1
    ]).

:-use_module(library(clpfd)).
:-use_module(pointTools).
:-use_module(drawing).
:-use_module(covid).
:-use_module(datastructures).


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

heuristic(Point, Result) :-
    % unpack point to cell
    Point = Cell-_,
    home(Home),
    mooreDistance(Cell, Home, Result).

distance(Point, Costs, Result) :-
    get_assoc(Point, Costs, Cost),
    heuristic(Point, HeuristicCost),
    Result #= Cost - HeuristicCost.


costToPoint(Costs, Points, Cost-Point) :-
    member(Point, Points),
    get_assoc(Point, Costs, Cost).


minimalNotVisitedPoint(ToVisit, Costs, MinimalPoint) :-
    findall(R, costToPoint(Costs, ToVisit, R), PairCostPoint),
    min_member(_-MinimalPoint, PairCostPoint).


allowedMove(Point1, Point2) :-
    Point1 = Cell1-PrevCovidFlag,
    adjacentPoints(Cell1, PossibleCell),
    inMaze(PossibleCell),
    (
        (

            not((mask(PossibleCell); doctor(PossibleCell))),
            Point2 = PossibleCell-PrevCovidFlag
        );
        (
            (mask(PossibleCell); doctor(PossibleCell)),
                Point2 = PossibleCell-1
        )
    ).

/*
        Main function for getting allowed moves
        for a star algorithm
*/
get_astar_moves(Point1, Point2) :-
    % First, move should be valid in terms of adjacency, and should be in maze
    allowedMove(Point1, Point2),
    Point2 = Cell2-CovidFlag,
    (
        (   
            % if cell in covid zone, then covid should be 1 (means we have mask/doctor)
            inCovidZone(Cell2),
            CovidFlag = 1
        );
        % overwise, we should not be in covid zone!
        not(inCovidZone(Cell2))
    ).

/*
    Perform main for cycle for a_start algorith
*/
a_start_helper([], _, ToVisit, ToVisit, _, Costs, Costs, ParentList, ParentList).

a_start_helper(AdjPoints, CurrentPoint, ToVisit, ResultToVisit, Visited, Costs, ResultCosts, ParentList, ResultParentList) :-
    AdjPoints = [V | AdjPointsTail],

    distance(CurrentPoint, Costs, D),

    PossibleDistanceToV #= D + 1,
    distance(V, Costs, CurrentDistaceToV),

    (
        (
            member(CurrentPoint, Visited),
            PossibleDistanceToV >= CurrentDistaceToV,
            % just skip this V
            a_start_helper(
                AdjPointsTail, CurrentPoint, 
                ToVisit, ResultToVisit, 
                Visited, 
                Costs, ResultCosts,
                ParentList, ResultParentList)
        );
        
        (
            % V not in Visited or tentativeScore < g[v]
            (not(member(CurrentPoint, Visited)); PossibleDistanceToV < CurrentDistaceToV),
            put_assoc(V, ParentList, CurrentPoint, UpdatedParentList),

            heuristic(V, VHValue),
            NewCost #= PossibleDistanceToV + VHValue,
            put_assoc(V, Costs, NewCost, UpdatedCosts),

            (
                (
                    member(V, ToVisit),UpdatedToVisit = ToVisit
                );
                (
                    UpdatedToVisit = [V | ToVisit]
                )
            ),

            a_start_helper(
                AdjPointsTail, 
                CurrentPoint, 
                UpdatedToVisit, ResultToVisit,
                Visited, 
                UpdatedCosts, ResultCosts,
                UpdatedParentList, ResultParentList)
        )
    ).




a_star(ToVisit, VisitedList, Costs, ParentList, ResultParentList) :-
    % CurrentPoint = ToVisit.pop(by=minimal_cost)
    minimalNotVisitedPoint(ToVisit, Costs, CurrentPoint),
    CurrentPoint = CurrentCell-_,
    (
        (
            % if current == homePoint:
            home(HomeCell),
            equalPoints(CurrentCell, HomeCell),
                % return ParentList
                ResultParentList = ParentList
        );
        % otherwise
        (
            % ToVisit.remove(CurrentPoint)
            delete(ToVisit, CurrentPoint, ToVisit1),
            
            % Visited.append(NewVisitedList)
            NewVisitedList = [CurrentPoint | VisitedList],
            
            % find all adjacent Cells
            findall(V, get_astar_moves(CurrentPoint, V), AdjacentCells),
            
            a_start_helper(
                AdjacentCells, 
                CurrentPoint, 
                ToVisit1, HelpedToVisit, 
                NewVisitedList, 
                Costs, HelpedCosts, 
                ParentList, HelpedParentList),
            
            a_star(HelpedToVisit, NewVisitedList, HelpedCosts, HelpedParentList, ResultParentList)
        )
    ).
    
findParentList(ResultParentList) :-
    initializeCosts(Costs),
    initializeParentList(ParentList),
    actor(ActorCell),
    StartPoint = ActorCell-0,

    heuristic(StartPoint, HValue),
    put_assoc(StartPoint, Costs, HValue, Costs1),

    a_star([StartPoint], [], Costs1, ParentList, ResultParentList).

restorePath(ParentList, ResultPath) :-
    home(HomeCell),
    between(0, 1, CovidFlag),
    restorePath(HomeCell-CovidFlag, ParentList, ResultPath).

% Finish ?
restorePath(CurrentPoint, _, ResultPath) :-
    actor(InitialCell),
    CurrentPoint = CurrentCell-_,
    equalPoints(InitialCell, CurrentCell),
    ResultPath = [InitialCell].

% Recursion
restorePath(CurrentPoint, ParentList, ResultPath) :-
    get_assoc(CurrentPoint, ParentList, PrevPoint),
    restorePath(PrevPoint, ParentList, PathToPrevPoint),
    
    CurrentPoint = CurrentCell-_,
    ResultPath = [CurrentCell | PathToPrevPoint].

find_astar_path(Path) :-
    findParentList(ParentList), !,
    restorePath(ParentList, ReversedPath),
    reverse(ReversedPath, Path).

    
