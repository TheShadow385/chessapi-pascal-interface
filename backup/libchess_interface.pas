unit libchess_interface;

{$mode ObjFPC}{$H+}

interface

uses
   ctypes;

type
  PBoard = Pointer;
  BitBoard = cuint64;

   //! Player color
   PlayerColor = (
       WHITE,
       BLACK
   );

   //! Piece type
   PieceType = (
       PAWN   = 1, // A pawn piece
       BISHOP = 2, // A bishop piece
       KNIGHT = 3, // A knight piece
       ROOK   = 4, // A rook piece
       QUEEN  = 5, // A queen piece
       KING   = 6  // A king piece
   );

   //! Game play state
   GameState = (
       GAME_CHECKMATE = -1, // Indicates the game has ended in a checkmate
       GAME_NORMAL    = +0, // Indicates the game has not ended yet
       GAME_STALEMATE = +1  // Indicates the game has ended in a draw
   );

  {$PACKRECORDS C}

  //! A Move represents a single chess move from a start location to an end location
  TMove = packed record
      from_move:BitBoard; // A BitBoard representing the origin of the move
      to_move:BitBoard;   // A BitBorad representing the target of the move
      promotion:cuint8;   // Will be one of the BISHOP, KNIGHT, ROOK, QUEEN constants above, or 0 if not required
      capture:cuint8;     // True if this move captures a piece
      castle:cuint8;      // True if this move is castling

      _padding: array[0..4] of cuint8; // manual padding
  end;
  PMove = ^TMove;

  {$IFDEF WINDOWS}
  const libchess='libchess.dll';
  {$ENDIF}
  {$IFDEF UNIX}
  const libchess='libchess.so';
  {$ENDIF}

function chess_get_board():PBoard;                                              cdecl; external libchess;
function chess_clone_board(Board:PBoard):PBoard;                                cdecl; external libchess;
function chess_get_legal_moves(Board:PBoard; len:Pcint):PMove;                  cdecl; external libchess;
function chess_get_legal_moves_inplace(board: PBoard; moves:PMove;
                                       maxlen_moves:csize_t):cint;              cdecl; external libchess;

function chess_is_white_turn(Board: PBoard):boolean;                            cdecl; external libchess;
function chess_is_black_turn(Board: PBoard):boolean;                            cdecl; external libchess;

procedure chess_skip_turn(Board: PBoard);                                       cdecl; external libchess;

function chess_in_check(Board: PBoard):boolean;                                 cdecl; external libchess;
function chess_in_checkmate(Board: PBoard):boolean;                             cdecl; external libchess;
function chess_in_draw(Board: PBoard):boolean;                                  cdecl; external libchess;

function chess_can_kingside_castle(Board: PBoard; color:PlayerColor):boolean;   cdecl; external libchess;
function chess_can_queenside_castle(Board: PBoard; color:PlayerColor):boolean;  cdecl; external libchess;

function chess_get_game_state(Board: PBoard):GameState;                         cdecl; external libchess;
function chess_is_game_ended(Board: PBoard):GameState;                          cdecl; external libchess;

function chess_zobrist_key(Board: PBoard):cuint64;                              cdecl; external libchess;

procedure chess_make_move(Board: PBoard; move:TMove);                           cdecl; external libchess;
procedure chess_undo_move(Board: PBoard);                                       cdecl; external libchess;

procedure chess_free_board(Board: PBoard);                                      cdecl; external libchess;

function chess_get_bitboard(Board: PBoard; color:PlayerColor;
                                           piece_type:PieceType):BitBoard;      cdecl; external libchess;

function chess_get_full_moves(Board: PBoard):cint;                              cdecl; external libchess;
function chess_get_half_moves(Board: PBoard):cint;                              cdecl; external libchess;

///// MOVE SUBMISSION /////

procedure chess_push(move: TMove);                                              cdecl; external libchess;
procedure chess_done;                                                           cdecl; external libchess;
function chess_board_from_fen(fen:PChar):PBoard;                                cdecl; external libchess;
procedure chess_dump_move(buffer:PChar; move:TMove);                            cdecl; external libchess;

///// TIME MANAGEMENT /////

function chess_get_time_millis:cuint64;                                         cdecl; external libchess;
function chess_get_opponent_time_millis:cuint64;                                cdecl; external libchess;
function chess_get_elapsed_time_millis:cuint64;                                 cdecl; external libchess;

///// BITBOARDS /////

function chess_get_piece_from_index(Board: PBoard, index: cint):PieceType;      cdecl; external libchess;
function chess_get_piece_from_bitboard(Board: PBoard;
                                       Bitboard:BitBoard):PieceType;            cdecl; external libchess;
function chess_get_color_from_index(Board: PBoard; index:cint):PlayerColor;     cdecl; external libchess;
function chess_get_color_from_bitboard(Board: PBoard;
                                       Bitboard:BitBoard):PlayerColor;          cdecl; external libchess;

function chess_get_index_from_bitboard(Bitboard:BitBoard):cint;                 cdecl; external libchess;
function chess_get_bitboard_from_index(index:cint):BitBoard;                    cdecl; external libchess;

///// OTHER /////

function chess_get_opponent_move(index:LongInt):TMove;                          cdecl; external libchess;
procedure chess_free_moves_array(moves:PMove);                                  cdecl; external libchess;

implementation

end.

