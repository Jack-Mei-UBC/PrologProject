withinBounds(CurrX,CurrY):-
    CurrX < 9,
    CurrX > -1,
    CurrY < 9,
    CurrY > -1.

    
rookMoves(X) :- X = [(0,1),(0,-1),(1,0),(-1,0)].
returnMovesValid(w,Board,X,Y,(X1,Y1),InList,OutList):-
    Y2 is Y+Y1,
    X2 is X+X1,
    withinBounds(X2,Y2),
    Z is (X-1)+(Y-1)*8+X1+Y1*8,
    nth0(Z,Board,piece("-","-",_,_)),
    append([(X2,Y2)],InList,WithinList),
    returnMovesValid(Board,X2,Y2,(X1,Y1),WithinList,OutList).
returnMovesValid(w,_,X,Y,(X1,Y1),InList,InList):-
    Y2 is Y+Y1,
    X2 is X+X1,
    \+withinBounds(X2,Y2).
returnMovesValid(w,_,X,Y,(X1,Y1),InList,InList):-
    Y2 is Y+Y1,
    X2 is X+X1,
    withinBounds(X2,Y2),
    Z is (X-1)+(Y-1)*8+X1+Y1*8,
    nth0(Z,Board,piece(b,_,_,_)).
test(Out):- initiate2(B),returnMovesValid(B,2,2,(0,1),[],Out).

initiate2(B) :- B = [piece(w,rook,1,1),piece(w,knight,2,1),piece(w,bishop,3,1),piece(w,queen,4,1),piece(w,king,5,1),piece(w,bishop,6,1),piece(w,knight,7,1),piece(w,rook,8,1),
piece(w, pawn,1, 2),piece(w, pawn,2, 2),piece(w, pawn, 3, 2),piece(w, pawn, 4, 2),piece(w, pawn, 5, 2),piece(w, pawn, 6, 2),piece(w, pawn, 7,2),piece(w, pawn, 8, 2),
piece("-","-",1,3),piece("-","-",2,3),piece("-","-",3,3),piece("-","-",4,3),piece("-","-",5,3),piece("-","-",6,3),piece("-","-",7,3),piece("-","-",8,3),
piece("-","-",1,4),piece("-","-",2,4),piece("-","-",3,4),piece("-","-",4,4),piece("-","-",5,4),piece("-","-",6,4),piece("-","-",7,4),piece("-","-",8,4),
piece("-","-",1,5),piece("-","-",2,5),piece("-","-",3,5),piece("-","-",4,5),piece("-","-",5,5),piece("-","-",6,5),piece("-","-",7,5),piece("-","-",8,5),
piece("-","-",1,6),piece("-","-",2,6),piece("-","-",3,6),piece("-","-",4,6),piece("-","-",5,6),piece("-","-",6,6),piece("-","-",7,6),piece("-","-",8,6),
piece(b, pawn,1, 7),piece(b, pawn,2, 7),piece(b, pawn, 3, 7),piece(b, pawn, 4, 7),piece(b, pawn, 5, 7),piece(b, pawn, 6, 7),piece(b, pawn, 7,7),piece(w, pawn, 8, 7),
piece(b,rook,1,8),piece(b,knight,2,8),piece(b,bishop,3,8),piece(b,queen,4,8),piece(b,king,5,8),piece(b,bishop,6,8),piece(b,knight,7,8),piece(w,rook,8,8)].