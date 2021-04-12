% piece_helper to validate the rules for the pieces
piece_helper(piece(C,pawn,X,Y),X1,Y1,Board) :-
    pawn_helper(C,Board,X,Y,X1,Y1).
piece_helper(piece(C,knight,X,Y),X1,Y1,Board) :-
    knight_helper(C,Board,X,Y,X1,Y1).
piece_helper(piece(C,king,X,Y),X1,Y1,Board) :-
    king_helper(C,Board,X,Y,X1,Y1).
piece_helper(piece(C,queen,X,Y),X1,Y1,Board) :-
    queen_helper(C,Board,X,Y,X1,Y1).
piece_helper(piece(C,bishop,X,Y),X1,Y1,Board) :-
    bishop_helper(C,Board,X,Y,X1,Y1).
piece_helper(piece(C,rook,X,Y),X1,Y1,Board) :-
    rook_helper(C,Board,X,Y,X1,Y1).
    
% Checks if the input is on the board
withinBounds(CurrX,CurrY) :-
    CurrX < 9,
    CurrX > -1,
    CurrY < 9,
    CurrY > -1.

% Due to the way they move, rooks, bishops and queens share the same code
rook_helper(C,Board,X,Y,X1,Y1)  :-
    rookSteps(Steps),
    returnMoves(C,Board,X,Y,Steps,[],Out),
    member((X1,Y1),Out).

% queen helper for rule  
queen_helper(C,Board,X,Y,X1,Y1)  :-
    queenSteps(Steps),
    returnMoves(C,Board,X,Y,Steps,[],Out),
    member((X1,Y1),Out).

%bishop helper for rules    
bishop_helper(C,Board,X,Y,X1,Y1)  :-
    bishopSteps(Steps),
    returnMoves(C,Board,X,Y,Steps,[],Out),
    member((X1,Y1),Out).


% Possible steps a piece can take
rookSteps(X) :- X = [(0,1),(0,-1),(1,0),(-1,0)].
bishopSteps(X) :- X = [(-1,-1),(-1,1),(1,-1),(1,1)].
queenSteps(X) :- X = [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)].

% Generates a list of valid moves for the piece
returnMoves(C,Board,X,Y,[H|T],InList,OutList) :-
    returnMovesValid(C,Board,X,Y,H,[],Out),
    append(Out,InList,MyList),
    returnMoves(C,Board,X,Y,T,MyList,OutList).
returnMoves(C,Board,X,Y,[_|T],InList,OutList) :-                      % If the moveset provides nothing useful
    returnMoves(C,Board,X,Y,T,InList,OutList).
returnMoves(C,Board,X,Y,[H],InList,OutList) :-
    returnMovesValid(C,Board,X,Y,H,[],Out),
    append(Out,InList,OutList).
returnMoves(_,_,_,_,[_],InList,InList).                           % If the moveset provides nothing useful

% Black piece  returning valid moves                                              
returnMovesValid(b,Board,X,Y,(X1,Y1),InList,OutList):-                % Normal Recursion case 
    Y2 is Y+Y1,
    X2 is X+X1,
    withinBounds(X2,Y2),
    Z is X2-1+(Y2-1)*8,
    nth0(Z,Board,piece("-","-",_,_)),
    append([(X2,Y2)],InList,WithinList),
    returnMovesValid(b,Board,X2,Y2,(X1,Y1),WithinList,OutList).
returnMovesValid(b,_,X,Y,(X1,Y1),InList,InList):-                     % Checks if out of board
    Y2 is Y+Y1,
    X2 is X+X1,
    \+withinBounds(X2,Y2).
returnMovesValid(b,Board,X,Y,(X1,Y1),InList,OutList):-                    % Checks if encounters diff color
    Y2 is Y+Y1,
    X2 is X+X1,
    withinBounds(X2,Y2),
    Z is X2-1+(Y2-1)*8,
    nth0(Z,Board,piece(w,_,X2,Y2)),
    append([(X2,Y2)],InList,OutList).

% White piece returning valid moves 
returnMovesValid(w,Board,X,Y,(X1,Y1),InList,OutList):-                % Normal Recursion case 
    Y2 is Y+Y1,
    X2 is X+X1,
    withinBounds(X2,Y2),
    Z is X2-1+(Y2-1)*8,
    nth0(Z,Board,piece("-","-",_,_)),
    append([(X2,Y2)],InList,WithinList),
    returnMovesValid(w,Board,X2,Y2,(X1,Y1),WithinList,OutList).
returnMovesValid(w,_,X,Y,(X1,Y1),InList,InList):-                     % Checks if out of board
    Y2 is Y+Y1,
    X2 is X+X1,
    \+withinBounds(X2,Y2).
returnMovesValid(w,Board,X,Y,(X1,Y1),InList,OutList):-                    % Checks if encounters diff color
    Y2 is Y+Y1,
    X2 is X+X1,
    withinBounds(X2,Y2),
    Z is X2-1+(Y2-1)*8,
    nth0(Z,Board,piece(b,_,X2,Y2)),
    append([(X2,Y2)],InList,OutList).
returnMovesValid(C,Board,X,Y,(X1,Y1),InList,InList) :-                                   % Checks if encounters same color
    Y2 is Y+Y1,
    X2 is X+X1,
    withinBounds(X2,Y2),
    Z is X2-1+(Y2-1)*8,
    nth0(Z,Board,piece(C,_,_,_)).
    

%Pawns helper valid moves black and white 
pawn_helper(w, Board, X, Y, X, Y1) :-
    Y1 is Y+1,
    withinBounds(X,Y1),
    Z is X-1+8*(Y1-1),
    nth0(Z,Board,piece("-","-",_,_)).

    
pawn_helper(b, Board, X, Y, X, Y1) :-
    Y1 is Y-1,
    withinBounds(1,Y1),
    Z is X-1+8*(Y1-1),
    nth0(Z,Board,piece("-","-",_,_)).
    
pawn_helper(w, Board, X,2,X, 4) :-
    withinBounds(X,4),
    Z is (X-1)+8*(3),
    Z1 is X-1+8*(2),
    nth0(Z,Board,piece("-","-",_,_)),
    nth0(Z1,Board,piece("-","-",_,_)).
    
pawn_helper(b, Board, X,7,X, 5) :-
    withinBounds(X,7),
    Z is (X-1)+8*(4),
    Z1 is X-1+8*(5),
    nth0(Z,Board,piece("-","-",_,_)),
    nth0(Z1,Board,piece("-","-",_,_)).

% pawn capture movement white on Board, looks at curr X and Y coordinate and return true if coordinate (X2,Y2) piece on the Board has a Black piece 
pawn_helper(w,Board,X,Y,X2,Y2):-
     Y>1,
     X2 is X+1,
     Y2 is Y+1,
     withinBounds(X,Y),
     withinBounds(X2,Y2),
     member(piece(b,_,X2,Y2),Board);
     Y>1,
     X2 is X-1,
     Y2 is Y+1,
     withinBounds(X,Y),
     withinBounds(X2,Y2),
     member(piece(b,_,X2,Y2),Board).
     
% pawn capture movement black      
pawn_helper(b,Board,X,Y,X2,Y2):-
    X2 is X+1,
    Y2 is Y-1,
    withinBounds(X,Y),
    withinBounds(X2,Y2),
    member(piece(w,_,X2,Y2),Board);
    X2 is X-1,
    Y2 is Y-1,
    withinBounds(X,Y),
    withinBounds(X2,Y2),
    member(piece(w,_,X2,Y2),Board).      
    

% Knights steps it can take based on Coord
knightSteps(X) :- X = [(2,1),(2,-1),(-2,1),(-2,-1),(-1,2),(-1,-2),(1,-2),(1,2)].

% Knight_helper , move validation for knight piece 
knight_helper(C,Board,X,Y,X1,Y1) :-
    knightSteps(Possibilities),
    X2 is X1-X,
    Y2 is Y1-Y,
    withinBounds(X1,Y1),
    Z is (X1-1)+8*(Y1-1),
    \+nth0(Z,Board,piece(C,_,_,_)),
    member((X2,Y2),Possibilities).
    
% Kings steps it can take on the Board 
kingSteps(X) :- X = [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)].

% king_helper, return true for moves that King can make 
king_helper(C,Board,X,Y,X1,Y1) :-
    kingSteps(Possibilities),
    X2 is X1-X,
    Y2 is Y1-Y,
    withinBounds(X1,Y1),
    Z is (X1-1)+8*(Y1-1),
    \+ nth0(Z,Board,piece(C,_,_,_)),
    member((X2,Y2),Possibilities).
    
    
