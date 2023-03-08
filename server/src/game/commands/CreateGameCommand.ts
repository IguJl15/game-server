import { Board } from "../entities/Board";
import Player from "../entities/Player";
import { BoardRepository } from "../repositories/BoardRepository";

class CreateGameCommand {
    constructor(
        private repository: BoardRepository
    ) {}
    
    execute(userName: String): String {
        const player1 = new Player(
            Utils.generateId(),
            userName,
            "X",
        )

        const board = new Board(
                Utils.generateId(),
                player1,
        )

        return this.repository.saveBoard(board)
    }
}