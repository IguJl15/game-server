import { AlreadyMarkedError } from "../Errors";
import Cloneable from "../utils/Cloneable";
import Player from "./Player";
import Square from "./Square";

export class Board extends Cloneable {
    boardId: string;

    player1: Player;
    player2!: Player;
    currentPlayer: Player;
    winner: Player | null

    status: "waiting" | "in game" | "finished"

    private squares: Square[]

    public get isFilled(): boolean {
        return !this.squares.some(x => x.value == null)
    }


    public constructor(
        boardId: string,
        player1: Player
    ) {
        super()
        this.boardId = boardId
        this.player1 = player1
        this.currentPlayer = player1
        this.winner = null

        this.status = "waiting"
        this.squares = Array.from({ length: 9 }, () => Square.blank())
    }

    /**
     * ### **ATTENTION**: this method automatically swap current player to the next one
     * 
     * Set the square in the given index with the current player symbol.]
     * @param position where player will mark
     * @throws AlreadyMarkedError
     */
    public mark(position: number) {
        let square = this.squares[position]

        if (square.value != null) throw new AlreadyMarkedError();

        square.value = this.currentPlayer.value

        this.checkBoard()

        this.currentPlayer = this.currentPlayer.id == this.player1.id
            ? this.player2
            : this.player1
    }

    checkBoard() {
        const victoryPaths = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
            [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6],
        ]

        if (victoryPaths.some(
            arrangement => arrangement.every(position => this.squares[position].value == this.currentPlayer.value)
        )) {
            this.setWinner(this.currentPlayer)
        }
    }

    setWinner(player: Player) {
        this.winner = player;
        this.status = "finished"
    }
}