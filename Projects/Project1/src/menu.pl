%include library's
:- [game].

printMenu :-
    nl,
    nl,
    write('|------------------------------------|'),
    nl,
    write('|             ASTERISMO              |'),
    nl,
    write('|------------------------------------|'),
    nl,
    write('|                                    |'),
    nl,
    write('|       > (1) Player & Player        |'),
    nl,
    write('|                                    |'),
    nl,
    write('|       > (2) Player & Machine       |'),
    nl,
    write('|                                    |'),
    nl,
    write('|       > (3) Machine & Machine      |'),
    nl,
    write('|                                    |'),
    nl,
    write('|       > (4) Exit                   |'),
    nl,
    write('|                                    |'),
    nl,
    write('|------------------------------------|'),
    nl,
    write('|        Created by:                 |'),
    nl,
    write('|                                    |'),
    nl,
    write('|       o Martim Silva               |'),
    nl,
    write('|       o Jose Guerra                |'),
    nl,
    write('|------------------------------------|'),
    nl,
    nl.

selectOption :-
    write('> Insert your option: '),
    menuInputHandler.

menuInputHandler :-
    read(Input),
    if_then_else(
        (
            Input == 1;
            Input == 2;
            Input == 3
        ),
        (
            if_then_else(
                (Input == 2 ; Input == 3),   
                readDifficulty(Level),
                true
            ),
            start(Input, Level)   
        ),
            if_then_else(
                Input == 4,
                true,
                play
            )
    ). 

readDifficulty(Level) :-
    write('> (1) AI level 0\n'),
    write('> (2) AI level 1\n'),
    write('Chose difficulty: '), 
    read(Level),
    if_then_else(
        (
            Level == 0;
            Level == 1
        ),
        true,
        readDifficulty(Level1)
    ).


play :-
    printMenu,
    selectOption.
