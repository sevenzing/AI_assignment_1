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
    0 A . . . . . . . M
    1 . . . . . . . . .
    2 . . . . . . . . .
    3 . . . . . . . . .
    4 . . . . . . . . .
    5 . . . . . . . . .
    6 . . . . . . . . C
    7 . . . . . . . . . 
    8 . . . . . . C D H

*/

actor(0-0).
mazeSize(9).

home(8-8).
covid(8-6).
covid(6-8).
doctor(7-8).
mask(8-0).
