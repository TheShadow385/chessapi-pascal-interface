program chess_interface;

uses
  Classes, SysUtils, Dialogs, libchess_interface;

var
   i:integer;
   CurrentBoard:PBoard;
   Moves:PMove;
   len:LongInt;

begin
   for i:=0 to 500 do
   begin
      CurrentBoard:=chess_get_board;

      chess_get_legal_moves(CurrentBoard,len);
      chess_push(moves[Random(25555) mod len]);

      chess_free_board(CurrentBoard);
      chess_done();
   end;
end.

