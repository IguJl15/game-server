import { GameState } from "../../api/Queries";
import { BoardNotFoundError } from "../Errors";
import { Board } from "../entities/Board";
import { BoardRepository } from "../repositories/BoardRepository";

/**
 * @returns Filtered board object without opponent id or both players ids
 */
export default
    class GetGameStateCommand {
    constructor(
        private repository: BoardRepository
    ) { }

    execute(params: GameState): Board {
        let board = this.repository.getBoard(params.boardId)

        if (board == null) throw new BoardNotFoundError()

        // mask ids
        if (params.playerId == null || params.playerId == '') {
            board.player1.id = ""
            if (board.player2) board.player2.id = ""
        }

        if (board.player2) {
            if (params.playerId == board.player1.id) board.player2.id = ""
            if (params.playerId == board.player2.id ?? "") board.player1.id = ""
        }

        return board;
    }
}