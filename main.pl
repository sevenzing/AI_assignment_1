:-use_module(library(clpfd)).
:-use_module(backtracking).
:-use_module(a_star).
:-use_module(drawing).
% import map
:-use_module(map).

bt_search :-
    % draw empty map
    draw_maze([]),
    
    % get constansts from map.pl
    home(HomePoint),
    actor(StartPoint),
    mazeSize(MSize),
    MaxIters #= MSize * MSize,

    % for N in range(0, MaxIters):
    between(0, MaxIters, N),
        % find path with len(FoundPath) < N
        backtracking(StartPoint, HomePoint, [StartPoint], N, FoundPath),

        write(FoundPath),nl,
        draw_maze(FoundPath).


a_star :- 
    draw_maze([]), nl,
    find_astar_path(FoundPath),
    write(FoundPath), nl,
    draw_maze(FoundPath).