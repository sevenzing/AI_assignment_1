:- module(map, [
    actor/1,
    covid/1,
    doctor/1,
    home/1,
    mask/1,
    mazeSize/1
    ]).
actor(0-0).
mazeSize(9).
/*
% 6X6 MAP
covid(3-3).
covid(3-1).
doctor(5-1).
home(5-5).
mask(1-1).
*/

/*
% 9X9 MAP EASY
covid(2-3).
covid(3-3).
doctor(5-1).
home(2-8).
mask(5-2).
*/

/*
6x6 ???
covid(4-0).
covid(5-1).
doctor(1-5).
mask(1-4).
home(5-0).
*/

covid(8-6).
covid(6-8).

covid(6-1).

doctor(0-9).
home(8-8).
mask(8-1).