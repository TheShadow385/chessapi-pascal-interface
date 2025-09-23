unit libchess_interface;

{$mode ObjFPC}{$H+}

interface


type
  PBoard = Pointer;
  PMove = Pointer;
  PInt = Pointer;
  BitBoard = QWord;

type
   //! Player color
   PlayerColor = (WHITE,BLACK);

   //! Piece type
   PieceType = (
       PAWN = 1, // A pawn piece
       BISHOP,   // A bishop piece
       KNIGHT,   // A knight piece
       ROOK,     // A rook piece
       QUEEN,    // A queen piece
       KING      // A king piece
   );

   //! Game play state
   GameState = (
       GAME_CHECKMATE = -1, // Indicates the game has ended in a checkmate
       GAME_NORMAL,         // Indicates the game has not ended yet
       GAME_STALEMATE       // Indicates the game has ended in a draw
   );

  //! A Move represents a single chess move from a start location to an end location
  TMove = packed record
      from_move:BitBoard;      // A BitBoard representing the origin of the move
      to_move:BitBoard;        // A BitBorad representing the target of the move
      promotion:Byte;     // Will be one of the BISHOP, KNIGHT, ROOK, QUEEN constants above, or 0 if not required
      capture:boolean;    // True if this move captures a piece
      castle:boolean;     // True if this move is castling
  end;


function chess_get_board:PBoard;                                                cdecl; external 'libchess.dll';
function chess_clone_board(Board:PBoard):PBoard;                                cdecl; external 'libchess.dll';
function chess_get_legal_moves(Board:PBoard; len:PInt):PMove; {Array}           cdecl; external 'libchess.dll';

function chess_is_white_turn(Board: PBoard):boolean;                            cdecl; external 'libchess.dll';
function chess_is_black_turn(Board: PBoard):boolean;                            cdecl; external 'libchess.dll';

procedure chess_skip_turn(Board: PBoard);                                       cdecl; external 'libchess.dll';

function chess_in_check(Board: PBoard):boolean;                                 cdecl; external 'libchess.dll';
function chess_in_checkmate(Board: PBoard):boolean;                             cdecl; external 'libchess.dll';
function chess_in_draw(Board: PBoard):boolean;                                  cdecl; external 'libchess.dll';

function chess_can_kingside_castle(Board: PBoard; color:PlayerColor):boolean;   cdecl; external 'libchess.dll';
function chess_can_queenside_castle(Board: PBoard; color:PlayerColor):boolean;  cdecl; external 'libchess.dll';

function chess_get_game_state(Board: PBoard):GameState;                         cdecl; external 'libchess.dll';
function chess_is_game_ended(Board: PBoard):GameState;                          cdecl; external 'libchess.dll';

function chess_zobrist_key(Board: PBoard):QWord;                                cdecl; external 'libchess.dll';

procedure chess_make_move(Board: PBoard; move:TMove);                           cdecl; external 'libchess.dll';
procedure chess_undo_move(Board: PBoard);                                       cdecl; external 'libchess.dll';

procedure chess_free_board(Board: PBoard);                                      cdecl; external 'libchess.dll';

function chess_get_bitboard(Board: PBoard; color:PlayerColor;
                                           piece_type:PieceType):BitBoard;      cdecl; external 'libchess.dll';

function chess_get_full_moves(Board: PBoard):LongInt;                           cdecl; external 'libchess.dll';
function chess_get_half_moves(Board: PBoard):LongInt;                           cdecl; external 'libchess.dll';

///// MOVE SUBMISSION /////

procedure chess_push(move: TMove);                                              cdecl; external 'libchess.dll';
procedure chess_done;                                                           cdecl; external 'libchess.dll';

///// TIME MANAGEMENT /////

function chess_get_time_millis:QWord;                                           cdecl; external 'libchess.dll';
function chess_get_opponent_time_millis:QWord;                                  cdecl; external 'libchess.dll';
function chess_get_elapsed_time_millis:QWord;                                   cdecl; external 'libchess.dll';

///// BITBOARDS /////

function chess_get_piece_from_index(Board: PBoard):PieceType;                   cdecl; external 'libchess.dll';
function chess_get_piece_from_bitboard(Board: PBoard;
                                       Bitboard:BitBoard):PieceType;            cdecl; external 'libchess.dll';
function chess_get_color_from_index(Board: PBoard; index:LongInt):PlayerColor;  cdecl; external 'libchess.dll';
function chess_get_color_from_bitboard(Board: PBoard;
                                       Bitboard:BitBoard):PlayerColor;          cdecl; external 'libchess.dll';

function chess_get_index_from_bitboard(Bitboard:BitBoard):LongInt;              cdecl; external 'libchess.dll';
function chess_get_bitboard_from_index(index:LongInt):BitBoard;                 cdecl; external 'libchess.dll';

///// OTHER /////

function chess_get_opponent_move(index:LongInt):BitBoard;                       cdecl; external 'libchess.dll';
function chess_free_moves_array(moves:PMove):BitBoard;                          cdecl; external 'libchess.dll';

function hello:boolean; cdecl; external 'libchess.dll';

implementation

end.

