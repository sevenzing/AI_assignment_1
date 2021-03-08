:- module(map, [
    actor/1,
    covid/1,
    doctor/1,
    home/1,
    mask/1,
    mazeSize/1
    ]).
/*
      0 1 2 3
    0 A . . M
    1 . . . .
    2 D . . C
    3 . . C H
*/

actor(0-0).
mazeSize(4).

home(3-3).
covid(2-3).
covid(3-2).
doctor(0-2).
mask(3-0).
