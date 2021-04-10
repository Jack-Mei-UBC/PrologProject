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
queen_helper(C,Board,X,Y,X1,Y1)  :-
    queenSteps(Steps),
    returnMoves(C,Board,X,Y,Steps,[],Out),
    member((X1,Y1),Out).
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

% Black piece                                                
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

% White piece
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
    

%Pawns
pawn_helper(w, Board, X, Y, X1, Y1) :-
    Y1 is Y+1,
    withinBounds(X1,Y1),
    Z is X-1+8*(Y1-1),
    nth0(Z,Board,piece("-","-",_,_)). 
    
pawn_helper(b, Board, X, Y, X1, Y1) :-
    Y1 is Y-1,
    withinBounds(1,Y1),
    Z is X1-1+8*(Y1-1),
    nth0(Z,Board,piece("-","-",_,_)).
    
pawn_helper(w, Board, X,2,X1, 4) :-
    withinBounds(X,4),
    Z is (X1-1)+8*(3),
    Z1 is X1-1+8*(2),
    nth0(Z,Board,piece("-","-",_,_)),
    nth0(Z1,Board,piece("-","-",_,_)).
    
pawn_helper(b, Board, X,7,X1, 5) :-
    withinBounds(X1,7),
    Z is (X1-1)+8*(4),
    Z1 is X1-1+8*(5),
    nth0(Z,Board,piece("-","-",_,_)),
    nth0(Z1,Board,piece("-","-",_,_)).

% pawn capture 
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
    

% Knights
knightSteps(X) :- X = [(2,1),(2,-1),(-2,1),(-2,-1),(-1,2),(-1,-2),(1,-2),(1,2)].

knight_helper(C,Board,X,Y,X1,Y1) :-
    knightSteps(Possibilities),
    X2 is X1-X,
    Y2 is Y1-Y,
    withinBounds(X1,Y1),
    Z is (X1-1)+8*(Y1-1),
    \+nth0(Z,Board,piece(C,_,_,_)),
    member((X2,Y2),Possibilities).
% Kings
kingSteps(X) :- X = [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)].

king_helper(C,Board,X,Y,X1,Y1) :-
    kingSteps(Possibilities),
    X2 is X1-X,
    Y2 is Y1-Y,
    withinBounds(X1,Y1),
    Z is (X1-1)+8*(Y1-1),
    \+ nth0(Z,Board,piece(C,_,_,_)),
    member((X2,Y2),Possibilities).
    
    
initiate2(B) :- B = [piece(w,rook,1,1),piece(w,knight,2,1),piece(w,bishop,3,1),piece(w,queen,4,1),piece(w,king,5,1),piece(w,bishop,6,1),piece(w,knight,7,1),piece(w,rook,8,1),
piece(w, pawn,1, 2),piece(w, pawn,2, 2),piece(w, pawn, 3, 2),piece(w, pawn, 4, 2),piece(w, pawn, 5, 2),piece(w, pawn, 6, 2),piece(w, pawn, 7,2),piece(w, pawn, 8, 2),
piece("-","-",1,3),piece("-","-",2,3),piece("-","-",3,3),piece("-","-",4,3),piece("-","-",5,3),piece("-","-",6,3),piece("-","-",7,3),piece("-","-",8,3),
piece("-","-",1,4),piece("-","-",2,4),piece("-","-",3,4),piece("-","-",4,4),piece("-","-",5,4),piece("-","-",6,4),piece("-","-",7,4),piece("-","-",8,4),
piece("-","-",1,5),piece("-","-",2,5),piece("-","-",3,5),piece("-","-",4,5),piece("-","-",5,5),piece("-","-",6,5),piece("-","-",7,5),piece("-","-",8,5),
piece("-","-",1,6),piece("-","-",2,6),piece("-","-",3,6),piece("-","-",4,6),piece("-","-",5,6),piece("-","-",6,6),piece("-","-",7,6),piece("-","-",8,6),
piece(b, pawn,1, 7),piece(b, pawn,2, 7),piece(b, pawn, 3, 7),piece(b, pawn, 4, 7),piece(b, pawn, 5, 7),piece(b, pawn, 6, 7),piece(b, pawn, 7,7),piece(w, pawn, 8, 7),
piece(b,rook,1,8),piece(b,knight,2,8),piece(b,bishop,3,8),piece(b,queen,4,8),piece(b,king,5,8),piece(b,bishop,6,8),piece(b,knight,7,8),piece(w,rook,8,8)].