:- module(drawing, [
    draw_maze/5
    ]).

:-use_module(library(clpfd)).

:-use_module(config).
:-use_module(tools).
:-use_module(pointTools).



draw_maze(HomeP, DoctorP, MaskP, CovidsPs, ThePath) :-
    mazeSize(MSize),
    draw_maze_helper(0-0, MSize, HomeP, DoctorP, MaskP, CovidsPs, ThePath).

draw_maze_helper(X-Y, M, _, _, _, _, _) :-
    X #= 0,
    Y #= M.

draw_maze_helper(X-Y, MSize, HomeP, DoctorP, MaskP, CovidsPs, ThePath) :-
    % Reach right edge
    X #= MSize,
    Y #< MSize,

    NewX #= 0,
    NewY #= Y + 1,

    nl,

    draw_maze_helper(NewX-NewY, MSize, HomeP, DoctorP, MaskP, CovidsPs, ThePath), !.


draw_maze_helper(X-Y, MSize, HomeP, DoctorP, MaskP, CovidsPs, ThePath) :-
    X #< MSize,
    Y #< MSize,

    draw_point(X-Y, HomeP, DoctorP, MaskP, CovidsPs, ThePath),!,

    NewX #= X + 1,
    NewY #= Y,

    draw_maze_helper(NewX-NewY, MSize, HomeP, DoctorP, MaskP, CovidsPs, ThePath), !.


draw_point(Point, HomeP, DoctorP, MaskP, CovidsPs, ThePath) :-
    (
        equalPoints(Point, HomeP),
        write("H ")
    );
    
    (
        equalPoints(Point, DoctorP),
        write("D ")
    );

    (
        equalPoints(Point, MaskP),
        write("M ")
    );

    (
        member(Point, CovidsPs),
        write("C ")
    );
    
    (
        member(Point, ThePath),
        write("o ")
    );

    write(". ").



    

