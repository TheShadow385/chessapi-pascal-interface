program example_bot;

{$mode objfpc}{$H+}

uses
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  TypInfo, SysUtils, Classes, libchess_interface, ctypes;

var
   i,j:integer;
   CurrentBoard:PBoard=nil;
   AllMoves:PMove=nil;
   moveCount:cint=0;

function BitboardToSquare(b: QWord): String;
const
  Files = 'abcdefgh';
var
  idx, fileIdx, rankIdx: Integer;
begin
  if b = 0 then
    Exit(''); // no piece

  // find index of the 1-bit
  idx := 0;
  while (b and 1) = 0 do begin
    b := b shr 1;
    Inc(idx);
  end;

  fileIdx := idx mod 8;
  rankIdx := idx div 8;

  Result := Files[fileIdx+1] + IntToStr(rankIdx+1);
end;

begin
   Randomize;

   for i:=0 to 500 do
   begin
      CurrentBoard:=chess_get_board();

      AllMoves:=chess_get_legal_moves(CurrentBoard,@moveCount);

      for j:=0 to moveCount-1 do
      begin
         DebugMsg(
                  BitboardToSquare(AllMoves[j].from_move)+'-'+BitboardToSquare(AllMoves[j].to_move)
                  +' cap:'+AllMoves[j].capture.ToString+' cas:'+AllMoves[j].castle.ToString+' pro:'+AllMoves[j].promotion.ToString
                  );
      end;

      if moveCount>0 then chess_push(AllMoves[Random(moveCount)]);

      chess_free_moves_array(AllMoves);
      chess_free_board(CurrentBoard);

      chess_done();
   end;
end.

