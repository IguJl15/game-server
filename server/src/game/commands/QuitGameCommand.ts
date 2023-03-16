import { CloseGame } from "../../api/Mutations";
import { Board } from "../entities/Board";
import { BoardRepository } from "../repositories/BoardRepository";
import Notifier from "../utils/Notifier";

export default
    class QuitGameCommand {
    constructor(
        private repository: BoardRepository,
        private playerNotifier: Notifier,
    ) { }

    execute(params: CloseGame): null {

        let board: Board | null

        if (params.boardId != null) board = this.repository.getBoard(params.boardId);
        else board = this.repository.getBoardByPlayerId(params.playerId);

        if (board == null) return null;

        // In waiting status means that second player never joined, so the host who quitted
        // Due to fact that all finished games are deleted, it is improbable, but not impossible, that a finished game remains on db
        // So the last status that would need some action is 'in game' status
        if (board.status == "in game") {
            const winner = params.playerId == board.player1.userId ? board.player2 : board.player1
            board.setWinner(winner)

            this.playerNotifier.notifyGameState(board, winner.userId);
        }

        return null
    }
}