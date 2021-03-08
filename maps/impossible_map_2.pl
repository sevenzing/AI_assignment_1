:- module(map, [
    actor/1,
    covid/1,
    doctor/1,
    home/1,
    mask/1,
    mazeSize/1
    ]).
/*
      0 1 2 3 4 5 6 7 8 
    0 A . C . . . . . .
    1 . . . . . . . . .
    2 . . . . . . . . .
    3 C . . . . . . . .
    4 . . . . . . . . .
    5 . . . . . . . . .
    6 . . . . . . . . M
    7 . . . . . . . . .
    8 . . . . . . D . H
*/

actor(0-0).
mazeSize(9).

home(8-8).
covid(2-0).
covid(0-3).
doctor(6-8).
mask(8-6).
