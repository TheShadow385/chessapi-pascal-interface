# Chess bot tournament Pascal interface
Pascal interface for Shiro's Chess bot API for the Neurocord Chess bot tournament

## Usage
- Download libchess_interface.pas
- include it in your project and your uses
- make sure libchessapi.dll/.so, compiled from Shiro's code, is in the same folder as the .exe

## Example
Simple bot that makes random moves, same as the one found in the original repository
```pascal
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
```


