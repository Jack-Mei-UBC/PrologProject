%Instructions 
instructions(Game):- 
                 write("Welcome to the Game of Chess \n"),
                 write("Would you like to see the Instructions?"),
                 repeat,
                 write("\nEnter 'yes.' to see the instructions and 'start.' to continue"),
                 read(Input),
                 string_lower(Input,Processed),
                 write(Processed),
                 sub_string(Processed,0,1,_,X),
                 sub_string(Processed,1,1,_,Y),
                 sub_string(Processed,2,1,_,Z),
                 answer_question(X,Y,Z,L1,L2,L3).
                
                 
% rule ref: https://en.wikipedia.org/wiki/King_(chess)#:~:text=A%20king%20can%20move%20one%20square%20in%20any,the%20move%20would%20place%20the%20king%20in%20check.           
% answer to the question yes for instructions and no to continue the game                  
answer_question(X,Y,Z,Letter1,Letter2,Letter3):-
        string_chars(X,[Letter1]),
        string_chars(Y,[Letter2]),
        string_chars(Z,[Letter3]),
        Letter1 = y,
        Letter2 = e,
        Letter3 = s,
        write("\n"),
        write(" CHESS GAME INSTRUCTION 101 \n"),
        write("  ------------------------------------------------------------------------------------------------------------------------- \n"),
        write("  |[ King Moves  ] - A king can move one square in any direction (horizontally, vertically, or diagonally)                 |\n"),
        write("  |[ Queen Moves ] - A Queen can move Up, Down, Right, Left, Diagonal both directions                                      |\n"),
        write("  |[ Bishop Moves] - Diagonal both directions                                                                              |\n"),
        write("  |[ Rook Moves  ] - Up, Down, Left, Right                                                                                 |\n"),
        write("  |[ Pawn Moves  ] - First move from starting position: two square or one square up                                        |\n"),
        write("  |                - Pawn Moves after: One square up, and one square diagonally to capture a piece                         |\n"),
        write("  |[ knight Moves] - Makes L-shape moves: moves two squares in any direction vertically followed by one square horizontally|\n"), 
        write("  |                 - or two squares in any direction horizontally followed by one square vertically                       |\n"),
        write("  |THE RESTRICTION FOR ALL MOVES: Move is only legal if friendly piece is not in it's way                                  |\n"),
        write("  |________________________________________________________________________________________________________________________|\n"),
        write("\n"),
        write(" ENJOY THE GAME (^.^)o[~] !"),
        write("\n");
        string_chars(X,[Letter1]),
        string_chars(Y,[Letter2]),
        string_chars(Z,[Letter3]),
        Letter1 = s,
        Letter2 = t,
        Letter3 = a,
        write("\n"),
        write(" ENJOY THE GAME (^.^)o[~] !"),
        write("\n").