:-use_module(backtracking).
:-use_module(drawing).

home(3-3).
doctor(3-0).
mask(0-3).
covids([]).

main :-
    home(HomeP),
    doctor(DoctorP),
    mask(MaskP),
    covids(CovidsPs),

    backtracking(HomeP, DoctorP, MaskP, CovidsPs, ThePath),!,
    write(ThePath),nl,
    draw_maze(HomeP, DoctorP, MaskP, CovidsPs, ThePath).
