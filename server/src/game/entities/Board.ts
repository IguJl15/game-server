import Player from "./Player";
import Square from "./Square"

export
class Board {
    private squares: Square[] = Array(9)
    public currentPlayer: Player;

    private player2!: Player;
    constructor(
        public id: String,

        private readonly player1: Player,
    ) {
        this.currentPlayer = player1
        this.squares.fill(Square.blank())
    }

    public player2Joined(player2: Player) {
        this.player2 = player2
    }

    public mark(position: number) {
        let square = this.squares[position]
        
        if(square.value != null) throw new AlreadyMarkedError();
        
        square.value = this.currentPlayer.value

        this.checkForWinner()
        
        this.currentPlayer = this.currentPlayer == this.player1 
                                                ? this.player2 
                                                : this.player1
    }
    
    checkForWinner() {
        const victoryPaths = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
            [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6],
        ]
        
        if (victoryPaths.some(arrangement => 
                arrangement.every(position => 
                    this.squares[position].value == this.currentPlayer.value
                )
            )) {
            console.log("Current ganhou")
        }
    }

}