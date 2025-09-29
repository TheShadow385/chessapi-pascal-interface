program chess_interface;

uses
  Classes, SysUtils, Dialogs, libchess_interface, ctypes;

var
   i:integer;
   CurrentBoard:PBoard;
   AllMoves:PMove;

   moveCount: cint;
   buf: array[0..7] of Char; // must be at least 7 bytes as per docs

begin
   WriteLn('started');

   for i:=0 to 500 do
   begin
      try
         try
            CurrentBoard:=chess_get_board();
         except
            WriteLn('Error getting board');
         end;
      finally
        WriteLn('got board');
      end;


      AllMoves:=chess_get_legal_moves(CurrentBoard,@moveCount);

      if moveCount>0 then chess_push(AllMoves[0]);

      chess_free_moves_array(AllMoves);
      chess_free_board(CurrentBoard);
      chess_done();
   end;

   WriteLn('done');

end.


