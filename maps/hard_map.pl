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
    0 A . . . . . M . D
    1 . . . . . . C . .
    2 . . . . . . . . .
    3 . . . . . . . . .
    4 . . . . . . . . .
    5 . . . . . . . . .
    6 . . . . . . . . .
    7 . C . . . . . . . 
    8 H . . . . . . . .

*/

actor(0-0).
mazeSize(9).

home(0-8).
covid(6-1).
covid(1-7).
doctor(8-0).
mask(6-0).
