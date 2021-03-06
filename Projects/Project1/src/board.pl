:- [allBoards].
:- (dynamic initialBoard/1).

%   Initial Configuration of Board
initialBoard([
    [n, n, n, n, n, n, n, n, n, n, n, n],
    [n, n, n, n, n, n, n, n, n, n, n, n],
    [n, n, n, n, n, n, n, n, n, n, n, n], 
    [n, n, n, n, n, n, n, n, n, n, n, n], 
    [n, n, n, n, n, n, n, n, n, n, n, n], 
    [n, n, n, n, n, n, n, n, n, n, n, n],
    [n, n, n, n, n, n, n, n, n, n, n, n], 
    [n, n, n, n, n, n, n, n, n, n, n, n], 
    [n, n, n, n, n, n, n, n, n, n, n, n], 
    [n, n, n, n, n, n, n, n, n, n, n, n], 
    [n, n, n, n, n, n, n, n, n, n, n, n]
]).

%   Conversion between what is stored and displayed     
piece(n, -).
piece(r, 'R').
piece(y, 'Y').
piece(b, 'B').

%   To print the top part of a line 
printBoardTop :-
    write('      _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _\n').

%   To print the columns headers
printBoardUp :-
    write('| a | b | c | d | e | f | g | h | i | j | l | m |\n ').

%   To print the contents of a line and prints the score of the players on the side 
printBoardLine([], 11):-
    write('|\n').

printBoardLine([], Line) :-
    PairLine is Line mod 2,
    if_then_else(PairLine == 0, write('|'), write('|_')),
    printPlayersScore(Line),
    write('\n').

printBoardLine([H|T], Line) :-
    write('|_'),
    piece(H, S),
    write(S),
    write('_'),
    printBoardLine(T, Line).
    
%   To print the contents of a line
printBoardBody([], 12).
printBoardBody([H|T], Line) :-
    %   Because theres another digit after line 10 that we need to account for
    if_then_else(Line<10, write(' '), true),
    
    %   Prints the number of the row
    write(Line),
    write('   '),
    Mod is Line mod 2,
    
    %   Prints a space that is used in case the row number is even
    if_then_else(Mod==0, write('  '), true),
    
    printBoardUp,
    write('    '),

    %   Prints the last _ if the row number is even
    if_then_else(Mod==0, write(' _'), true),

    %   Iterates through the rows of the board
    printBoardLine(H, Line),
    LineI is Line+1,
    printBoardBody(T, LineI).

%   Prints the current Board
printBoard:-
    initialBoard(Init),
    printBoardTop,
    printBoardBody(Init, 1), !.

%   Prints the board sent in variable X
printBoard(X):-
    printBoardTop,
    printBoardBody(X, 1).

%   Chooses a ramdom board for the game, out of those predefined in allboard.pl
randomizeBoard :-
    random(1, 6, BoardNumber),
    if_then_else(
            BoardNumber == 1,
            (retract(initialBoard(In)), board1(Out), assert(initialBoard(Out))),
            if_then_else(
                BoardNumber == 2,
                (retract(initialBoard(In)), board2(Out), assert(initialBoard(Out))),
                if_then_else(
                    BoardNumber == 3,
                    (retract(initialBoard(In)), board3(Out), assert(initialBoard(Out))),
                    if_then_else(
                        BoardNumber == 4,
                        (retract(initialBoard(In)), board4(Out), assert(initialBoard(Out))),
                        (retract(initialBoard(In)), board5(Out), assert(initialBoard(Out)))
                    )     
            )               
        )
    ).