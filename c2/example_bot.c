// Example C bot using the Chess API

#include "chessapi.h"
#include <stdlib.h>
#include <stdio.h>


int main(int argc, char *argv[]) {
	
	printf("Started");
	fflush(stdout);
	
    for (int i = 0; i < 500; i++) {
		printf("loop start");
        // at the start of our turn, get the board
        Board *board = chess_get_board();
		
		printf("got board");
		fflush(stdout);
		
        // find all legal moves for the position
        int len_moves;
        Move *moves = chess_get_legal_moves(board, &len_moves);
        // play one at random
        chess_push(moves[rand() % len_moves]);
        // cleanup
        free(moves);
        chess_free_board(board);
        // end our turn
        chess_done();
		
		printf("--");
		fflush(stdout);
    }	
	
	printf("Done");
	fflush(stdout);
}
