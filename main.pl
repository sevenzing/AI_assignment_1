:-use_module(backtracking).
:-use_module(drawing).
:-use_module(map).
:-use_module(library(clpfd)).
:-use_module(config).

bt_search :-
    draw_maze([]),
    home(HomePoint),
    actor(StartPoint),
    mazeSize(MSize),
    MaxIters #= MSize * MSize,

    between(0, MaxIters, N),
    backtracking(StartPoint, HomePoint, [StartPoint], N, FoundPath),
    write(FoundPath),nl,
    draw_maze(FoundPath)
    . 
