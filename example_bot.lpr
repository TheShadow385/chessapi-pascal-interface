program example_bot;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  TypInfo, SysUtils, Classes, libchess_interface, ctypes;

var
   i:integer;
   CurrentBoard:PBoard=nil;
   AllMoves:PMove=nil;
   moveCount:cint=0;

begin
   Randomize;

   for i:=0 to 500 do
   begin
      CurrentBoard:=chess_get_board();

      AllMoves:=chess_get_legal_moves(CurrentBoard,@moveCount);

      if moveCount>0 then chess_push(AllMoves[Random(moveCount)]);

      chess_free_moves_array(AllMoves);
      chess_free_board(CurrentBoard);

      chess_done();
   end;
end.

