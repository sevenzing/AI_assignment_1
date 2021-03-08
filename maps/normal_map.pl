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
    0 A H . . M D . . .
    1 . . C . . . . . .
    2 . . . . . . . . .
    3 . . . . . . . . .
    4 . . C . . . . . .
    5 . . . . . . . . .
    6 . . . . . . . . .
    7 . . . . . . . . . 
    8 . . . . . . . . .

*/

actor(0-0).
mazeSize(9).

home(2-0).
covid(2-4).
covid(2-1).
doctor(5-0).
mask(4-0).
