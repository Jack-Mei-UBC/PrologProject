knightTest(C,X,Y,X1,Y1) :- initiate2(Board),knight_helper(C,Board,X,Y,X1,Y1).

knightTests:-
    \+knightTest(w,0,0,1,2),
    \+knightTest(w,0,0,2,1),
    \+knightTest(w,0,0,2,3),
    knightTest(w,1,1,2,3),
    knightTest(w,8,8,7,6).
    
kingTest(C,X,Y,X1,Y1) :- initiate2(Board),king_helper(C,Board,X,Y,X1,Y1).
kingTests:-
    \+kingTest(w,0,0,1,1),
    \+kingTest(w,0,0,-1,1),
    \+kingTest(w,0,0,-1,0),
    kingTest(w,2,2,3,3),
    kingTest(w,8,8,7,7).
    
testRook(Out):- initiate2(B),rookSteps(X),returnMoves(w,B,2,2,X,[],Out).
testQueen(Out):- initiate2(B),queenSteps(X),returnMoves(w,B,2,2,X,[],Out).
queenTest:-
    initiate2(Board),
    queen_helper(w,Board,2,2,5,5),
    queen_helper(w,Board,2,2,7,7),
    \+queen_helper(w,Board,2,2,1,1),
testBishop(Out):- initiate2(B),bishopSteps(X),returnMoves(w,B,2,2,X,[],Out).

% TEST IT NOW PAWN 101
% white test  X=1 Y=1 , should not be valid FaLSE CASE TEST 

test:- initiate2(B),pawn_helper(w,B,1,1,2,1).

% greatly out of bounds  returns false 
test2:- initiate2(B),pawn_helper(w,B,2,1,4,4).

% move backwards one step & mutiple step returns false & diagnoal backwards left 
test3:-initiate2(B),pawn_helper(w,B,2,2,2,1).

test3m :- initiate2(B), pawn_helper(w,B,2,4,2,1).
test3dl:- initiate2(B),pawn_helper(w,B,2,2,1,1).
test3dr:- initiate2(B),pawn_helper(w,B,2,2,3,1).
 

% move sideways 
test4:- initiate2(B),pawn_helper(w,B,2,2,1,2).
test4L:- initiate2(B),pawn_helper(w,B,2,2,3,2).



% Test White valid moves -- start game move 2 steps fowards ok 
test2steps:- initiate2(B),pawn_helper(w,B,2,2,2,4),
             initiate2(B),pawn_helper(w,B,1,2,1,4),
             initiate2(B),pawn_helper(w,B,3,2,3,4),
             initiate2(B),pawn_helper(w,B,4,2,4,4),
             initiate2(B),pawn_helper(w,B,5,2,5,4),
             initiate2(B),pawn_helper(w,B,6,2,6,4),
             initiate2(B),pawn_helper(w,B,7,2,7,4),
             initiate2(B),pawn_helper(w,B,8,2,8,4).
             
%currently should return false because state of board has empty 
test_diagonal_startR:- initiate2(B),pawn_helper(w,B,1,2,2,3),
             initiate2(B),pawn_helper(w,B,2,2,3,3),
             initiate2(B),pawn_helper(w,B,3,2,4,3),
             initiate2(B),pawn_helper(w,B,4,2,5,3),
             initiate2(B),pawn_helper(w,B,5,2,6,3),
             initiate2(B),pawn_helper(w,B,6,2,7,3),
             initiate2(B),pawn_helper(w,B,7,2,8,3).
%currently should return false because state of board has empty 
test_diagonal_startL:- 
             initiate2(B),pawn_helper(w,B,2,2,1,3),
             initiate2(B),pawn_helper(w,B,3,2,1,3),
             initiate2(B),pawn_helper(w,B,4,2,3,3),
             initiate2(B),pawn_helper(w,B,5,2,4,3),
             initiate2(B),pawn_helper(w,B,6,2,5,3),
             initiate2(B),pawn_helper(w,B,7,2,6,3),
             initiate2(B),pawn_helper(w,B,7,2,6,3).
% test out of Bounds
outOfBounds:- initiate2(B),pawn_helper(w,B,-1,-1,9,1).
outOfBounds2:-initate2(B),pawn_helper(b,B,-1,0,8,9).
              
             
test(Z):-fixInput(X,Y,X1,Y1),
    Z is (X-1)+8*(Y-1).
