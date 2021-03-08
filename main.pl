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
    get_time(TimeStart),

    % for N in range(0, MaxIters):
    between(0, MaxIters, N),
        % find path with len(FoundPath) < N
        backtracking(StartPoint, HomePoint, [StartPoint], N, FoundPath),
        
        get_time(TimeEnd),
        write("Path: "),
        write(FoundPath),nl,
        draw_maze(FoundPath),
        ElapsedTime is TimeEnd - TimeStart,
        length(FoundPath, Length),
        format('~d steps to reach home\nElapsed time is ~4f s\n', [Length, ElapsedTime]).


a_star :- 
    draw_maze([]), nl,
    get_time(TimeStart),
    find_astar_path(FoundPath),
    get_time(TimeEnd),
    write("Path: "),
    write(FoundPath), nl,
    draw_maze(FoundPath),
    ElapsedTime is TimeEnd - TimeStart,
    length(FoundPath, Length),
    format('~d steps to reach home\nElapsed time is ~4f s\n', [Length, ElapsedTime]), 
    
    nl.