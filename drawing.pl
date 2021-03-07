:- module(drawing, [
    draw_maze/1
    ]).

:-use_module(library(clpfd)).

:-use_module(config).
:-use_module(pointTools).

% import map
:-use_module(map).


draw_maze(Path) :-
    mazeSize(MSize),
    % CovidPs = [1-1, 2-3, ... ]
    findall(X, covid(X), CovidsPs),
    home(HomeP),
    doctor(DoctorP),
    mask(MaskP),

    draw_maze_helper(0-0, MSize, HomeP, DoctorP, MaskP, CovidsPs, Path).

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
        actor(StartPoint),
        equalPoints(Point, StartPoint),
        write("@ ")
    );
    
    (
        equalPoints(Point, HomeP),
        ((member(Point, ThePath), write("h ")); write("H "))
    );
    
    (
        equalPoints(Point, DoctorP),
        ((member(Point, ThePath), write("d ")); write("D "))
    );

    (
        equalPoints(Point, MaskP),
        ((member(Point, ThePath), write("m ")); write("M "))
    );

    (
        member(Point, CovidsPs),
        ((member(Point, ThePath), write("c ")); write("C "))
    );

    (
        ((member(Point, ThePath), write("o ")); write(". "))
    ).
