unit hello_interface;

{$mode ObjFPC}{$H+}

interface

function hello:boolean; cdecl; external 'hello.dll';

implementation

end.

