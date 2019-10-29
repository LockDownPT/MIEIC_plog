%   include library's
:- [board].
:- [rules].
:- [players].

%   Starts players with player mode
startPP :-
    initGame(Init),
    playLoop.

%   Randomizes initial Board and prints it
initGame(BoardIn) :-
    initialBoard(BoardIn),
    printBoard(BoardIn).

%   Loop of playing
%I agree that there is no command you can use to change a variable once 
%it is bound. What you can do though, is force backtracking through the 
%assignment, then this variable can be set again. 

playLoop :-
    
    write('Player1:\n'),
    removePieceAsk(Color),
    addPieceToWhatPlayer(1, Color),

    write('Player2:\n'),
    removePieceAsk(Color),
    addPieceToWhatPlayer(2, Color),
    
    printPlayersCurrentScore,
    
    playLoop.

%   Asks for user input to decide specifics of
%   the play move, specifically row and column
removePieceAsk(Color) :-
        write('> Removing piece...\n'),
        write('> Select row: '),
        read(Row), 
        write('> Select column: '),
        read(Column),
        checkMove(Row, Column , ErrorType),
        initialBoard(BoardIn),
        (
                ErrorType == 0 -> (
                                    removePieceDo(BoardIn, BoardOut, Row, Column, Color), 
                                    printBoard(BoardOut)
                                  );         
                (
                    removePieceAsk
                )
        ).

removePieceDo(BoardIn, BoardOut, Row, Column, Color) :-
    retract(initialBoard(BoardIn)),
    removePiece(BoardIn, BoardOut, Row, Column, Color),
    assert(initialBoard(BoardOut)).

%   Checks if row, column respect board limits

checkMove(Row, Column, ErrorType):-
    (  
        (Row > 0, Row < 12, Column > 0, Column < 13) -> checkRules(Row, Column, ErrorType);
        ErrorType = 4),
    
    (
        (
            ErrorType == 0 -> true ;         
            (
                (
                    (ErrorType == 1, write('Tried to remove a piece that doesnt exist\n'));
                    (ErrorType == 2,  write('Tried to remove a piece that makes other pieces unprotected\n'));
                    (ErrorType == 3,  write('Tried to remove a piece that breaks the game tree\n'));
                    (ErrorType == 4,  write('Tried to remove a piece that is out of bonds\n'))
                ),
                write(' Try Again \n')
            )
        )
    ).

%   Removes the piece from BoardIn and updates in BoardOut
removePiece(BoardIn, BoardOut, Row, Column, Color) :-
    updateRow(Row, Column, BoardIn, BoardOut, Color).

%
updateColumn(1, [H|T], [Hout|T], Color):-
    Hout = nullCell,
    colorPiece(H, Color).
%
updateColumn(Column, [H|T], [H|Tout], Color):-
    Column > 1,
    ColumnI is Column - 1, 
    updateColumn(ColumnI, T, Tout, Color).
%
updateRow(1, Column, [H|T], [Hout|T], Color):-
    updateColumn(Column, H, Hout).
%    
updateRow(Row, Column, [H|T], [H|Tout], Color):-
    Row > 1,
    RowNext is Row - 1, 
    updateRow(RowNext, Column, T, Tout, Color).