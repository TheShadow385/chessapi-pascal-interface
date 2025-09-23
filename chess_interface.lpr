program chess_interface;

uses
  Classes, SysUtils, Dialogs, libchess_interface;

var
   CurrentBoard:PBoard;

begin
   hello;

   CurrentBoard:=chess_get_board;

   WriteLn('done');
   ReadLn;
end.

