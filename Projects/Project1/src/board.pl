:- (dynamic initialBoard/1).

initialBoard([
        [red, red, blue, yellow, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell],
        [yellow, blue, red, blue, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell],
        [yellow, yellow, red, yellow, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell], 
        [blue, red, blue, yellow, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell], 
        [yellow, yellow, blue, red, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell], 
        [blue, red, blue, yellow, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell],
        [yellow, red, blue, red, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell], 
        [red, red, blue, yellow, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell], 
        [red, red, red, red, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell], 
        [red, red, red, red, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell], 
        [red, red, red, red, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell, nullCell]
    ]).

%   Conversion between what is stored and whats is displayed     
piece(nullCell, -).
piece(red, 'R').
piece(yellow, 'Y').
piece(blue, 'B').
%
printLineConst :-
    write('\n---|---|---|---|---|---|---|---|---|---|---|---|---|\n').
%
printBoardTop :-
    write('      _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _\n').
%
printBoardUp :-
    write('| a | b | c | d | e | f | g | h | i | j | l | m |\n ').
%
printBoardLine([], 11):-
    write('|\n').
printBoardLine([], Line) :-
    Aux is Line mod 2,
    (
        (
            Aux==0, !, write('|\n')
        )
        ;
        write('|_\n')
    ).
printBoardLine([H|T], Line) :-
    write('|_'),
    piece(H, S),
    write(S),
    write('_'),
    printBoardLine(T, Line).
%
printBoardBody([], 12).
printBoardBody([H|T], Line) :-
    (   
        (
            Line<10, !,
            write(' ')
        )
        ;  
        Line>9
    ),
    write(Line),
    write('   '),
    Mod is Line mod 2,
    (  
        (
            Mod == 0, !,
            write(' _')
        )
        ;  
        Mod == 1
    ),
    printBoardUp,
    write('    '),
    (  
        (
            Mod == 0, !,
            write(' _')
        )
        ;  
        Mod == 1
    ),
    printBoardLine(H, Line),
    LineI is Line+1,
    printBoardBody(T, LineI).
%
printBoard(X) :-
    printBoardTop,
    printBoardBody(X, 1).
%
print :-
    initialBoard(Init),
    printBoard(Init).


%--------------------------------------------------------------------------------------------------------------------
% RANDOM BOARD EXPERIENCE
%--------------------------------------------------------------------------------------------------------------------

colorIndex(red, 1).
colorIndex(yellow, 2).
colorIndex(blue, 3).

randomBoard(BoardIn) :-
    initialBoard(BoardIn),
    randomBoardPiece(BoardIn, BoardOut, 1, 1, 0).
%
randomBoardPiece(BoardIn, BoardOut, Row, Column, Counter) :-
    (
            Random = 1, %random(1, 3, Random),
            CounterN is Counter + 1,
            Counter < 63,
            colorIndex(Color, Random),
            retract(initialBoard(BoardIn)),
            randomPiece(BoardIn, BoardOut, Row, Column, Color),
            assert(initialBoard(BoardOut)),
            (
                Column < 6 -> (ColumnN is Column + 1, randomBoardPiece(BoardOut, BoardOut2, Row, ColumnN, CounterN)) ;
                (RowN is Row + 1, randomBoardPiece(BoardOut, BoardOut2, RowN, Column, CounterN))
            )
    ); true.

%   Randomizes the piece from BoardIn and updates in BoardOut
randomPiece(BoardIn, BoardOut, Row, Column, Color) :-
    updateRowRandom(Row, Column, BoardIn, BoardOut, Color).
%
updateColumnRandom(1, [H|T], [Hout|T], Color):-
    Hout = Color, !.
%
updateColumnRandom(Column, [H|T], [H|Tout], Color):-
    ColumnI is Column - 1, 
    updateColumnRandom(ColumnI, T, Tout, Color).
%
updateRowRandom(1, Column, [H|T], [Hout|T], Color):-
    updateColumnRandom(Column, H, Hout, Color), !.
%    
updateRowRandom(Row, Column, [H|T], [H|Tout], Color):-
    Row > 1,
    RowNext is Row - 1, 
    updateRowRandom(RowNext, Column, T, Tout, Color).
%--------------------------------------------------------------------------------------------------------------------